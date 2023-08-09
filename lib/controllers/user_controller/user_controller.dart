import 'dart:convert' show jsonEncode;
import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  Future<void> setUser(dynamic newUser) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (newUser == null) {
      user.value = null;
      sp.remove(userKey);
      return;
    }
    if (newUser is User) {
      user.value = newUser;
    } else {
      user.value = User.fromJson(newUser);
    }
    await sp.setString(userKey, jsonEncode(currentUser));
  }

  User? get currentUser => user.value;
  bool get isLoggedIn => user.value != null;
}
