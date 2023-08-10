import 'dart:convert' show jsonDecode;
import 'dart:io' show File;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:impulse/consts/strings.dart';
import 'package:http/http.dart' as http;
import 'package:impulse/controllers/user_controller.dart';
import 'package:impulse/services/auth_service.dart';
import 'package:impulse/utils/compressor.dart';
import 'package:path/path.dart' show basename;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:uuid/uuid.dart' show Uuid;

enum SPActions {
  set,
  get,
  delete,
}

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final AuthService _authService = AuthService();
  final UserController _user = Get.find<UserController>();

  FirebaseService._privateConstructor();

  static final FirebaseService _instance =
      FirebaseService._privateConstructor();

  factory FirebaseService.instance() => _instance;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw Exception("Google sign-in failed or was canceled.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final response = await _authService.signUpUser(
          name: user.displayName!,
          email: user.email!,
          password: user.uid,
          phone: user.phoneNumber ?? "",
          downloadableProfileUrl: user.photoURL ?? "",
          method: 1, // for google
        );

        if (response['status'] == 200) {
          await _user.setUser(jsonDecode(response['body']));
          if (_user.currentUser!.downloadableProfileUrl.isNotEmpty) {
            await downloadProfileImage();
          }
          return;
        } else {
          throw Exception(response['error'] ?? response['body']['msg']);
        }
      } else {
        throw Exception("User not authenticated properly.");
      }
    } catch (e) {
      throw Exception(
          "An error occurred during Google sign-in: ${e.toString()}");
    }
  }

  Future<String> copyFile({required String filepath}) async {
    final file = File(filepath);
    final appDir = await getApplicationDocumentsDirectory();
    final copyPath = '${appDir.path}/${basename(file.path)}';
    List<int>? compressedImageData = await compressImage(
      filePath: file.path,
      quality: 50,
    );
    if (compressedImageData != null) {
      await File(copyPath).writeAsBytes(compressedImageData);
    }
    return copyPath;
  }

  Future<void> updateProfilePic({required String profilePicPath}) async {
    final profileData = await _uploadProfilePicture(
      userId: _user.currentUser!.id,
      profilePicPath: profilePicPath,
    );
    await _auth.currentUser!.updatePhotoURL(
      profileData[downloadProfileUrl],
    );
    await _user.setUser(_user.currentUser!.copyWith(
      profileUrl: profileData[profileUrl],
      downloadableProfileUrl: profileData[downloadProfileUrl],
    ));
  }

  Future<String?> uploadFile({
    required String filePath,
    required String type,
  }) async {
    final String fileName = filePath.split('_').last;
    final String storagePath = '${_user.currentUser!.id}/$type/$fileName';
    try {
      final file = File(filePath);
      if (file.existsSync()) {
        final storageRef = _storage.ref(storagePath);
        await storageRef.putFile(file);
        return storageRef.getDownloadURL();
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteUserDocumentary({required String doc}) async {
    try {
      final ref = _storage.ref('${_user.currentUser!.id}/$doc/');
      final result = await ref.listAll();
      for (final childRef in result.items) {
        await childRef.delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, String>> _uploadProfilePicture({
    required String userId,
    required String profilePicPath,
  }) async {
    final file = File(profilePicPath);
    final fileName = '${const Uuid().v4()}_${basename(file.path)}';

    final copyPath = await copyFile(filepath: profilePicPath);
    deleteUserDocumentary(doc: "profile_pictures");
    final storageRef =
        _storage.ref().child('$userId/profile_pictures').child(fileName);
    final uploadTask = storageRef.putFile(file);
    await uploadTask.whenComplete(() => null);

    final profilePicUrl = await storageRef.getDownloadURL();
    return {
      downloadProfileUrl: profilePicUrl,
      profileUrl: copyPath,
    };
  }

  Future<void> logOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      await _deleteProfilePicture();
      _user.setUser(null);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _deleteProfilePicture() async {
    final file = File(_user.currentUser!.profileUrl);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  Future<void> downloadProfileImage() async {
    try {
      final response =
          await http.get(Uri.parse(_user.currentUser!.downloadableProfileUrl));
      if (response.statusCode == 200) {
        final appDir = await getApplicationDocumentsDirectory();
        const uuid = Uuid();
        final file = File('${appDir.path}/profile_${uuid.v4()}.jpg');
        await _deleteProfilePicture();
        await file.writeAsBytes(response.bodyBytes);
        _user.setUser(_user.currentUser!.copyWith(profileUrl: file.path));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<String?> downloadFile({required String fileURL}) async {
  //   try {
  //     final fileName = getFileName(url: fileURL);
  //     final response = await http.get(Uri.parse(fileURL));
  //     if (response.statusCode == 200) {
  //       final appDir = await getApplicationDocumentsDirectory();
  //       final file = File('${appDir.path}/downloaded/_$fileName');
  //       await file.create(recursive: true);
  //       await file.writeAsBytes(response.bodyBytes);
  //       return file.path;
  //     }
  //     return null;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
