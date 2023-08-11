import 'dart:io' show File;
import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/user_controller.dart';
import 'package:impulse/models/user.dart';
import 'package:impulse/services/firebase_service.dart';
import 'package:impulse/views/auth_screen/login_screen.dart';
import 'package:impulse/widget_common/dialog_boxs.dart';
import 'package:impulse/widget_common/loading/loading_screen.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final loader = LoadingScreen.instance();
    final firebase = FirebaseService.instance();
    const dummyUser = User(
      id: "",
      name: name,
      email: emailHint,
      password: "",
    );

    void showLoader({
      required String message,
      required String title,
    }) =>
        loader.show(
          context: context,
          text: "Please wait...",
          title: "Login-out",
        );

    void showError({required String message, required String title}) =>
        errorDialogue(
          context: context,
          message: message,
          title: title,
        );

    void logOut() async {
      if (await confirmDialogue(
        context: context,
        message: "Are you sure you want to logout?",
        title: "Logout",
      )) {
        try {
          showLoader(message: "Please wait...", title: "Loggin-out");
          await firebase.logOut();
          loader.hide();
        } catch (e) {
          loader.hide();
          showError(message: e.toString(), title: "Error");
        }
      }
    }

    Widget getProfile() {
      if (userController.isLoggedIn) {
        final profileUrl = userController.currentUser!.profileUrl;
        final downloadableProfileUrl =
            userController.currentUser!.downloadableProfileUrl;
        if (profileUrl.isNotEmpty && File(profileUrl).existsSync()) {
          return circularBox(
            widget: Image.file(File(profileUrl)),
          );
        } else if (downloadableProfileUrl.isNotEmpty) {
          firebase.downloadProfileImage();
        }
      }
      return circularBox(widget: dummyAvt());
    }

    return Obx(
      () => Row(
        children: <Widget>[
          getProfile(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (userController.isLoggedIn
                        ? userController.currentUser!.name
                        : dummyUser.name)
                    .text
                    .white
                    .fontFamily(bold)
                    .make(),
                (userController.isLoggedIn
                        ? userController.currentUser!.email
                        : dummyUser.email)
                    .text
                    .size(10)
                    .white
                    .make(),
              ],
            ),
          ),
          OutlinedButton(
              onPressed: userController.isLoggedIn
                  ? logOut
                  : () async => await Get.to(
                        () => const LoginScreen(),
                      ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: "Logout".text.white.make())
        ],
      ),
    );
  }

  Icon dummyAvt() => const Icon(Icons.person, size: 35, color: mehroonColor);

  Widget circularBox({required Widget widget}) => widget.box
      .color(lightGolden)
      .roundedFull
      .size(50, 50)
      .clip(Clip.antiAlias)
      .make();
}
