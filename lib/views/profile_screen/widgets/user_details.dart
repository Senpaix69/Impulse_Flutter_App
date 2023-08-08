import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/user_controller/user_controller.dart';
import 'package:impulse/models/user.dart';
import 'package:impulse/views/auth_screen/login_screen.dart';
import 'package:impulse/widget_common/applogo_widget.dart';
import 'package:impulse/widget_common/dialog_boxs.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    const dummyUser = User(
        id: "",
        name: name,
        email: emailHint,
        password: "",
        address: "",
        type: "",
        token: "");

    void logOut() async {
      if (await confirmDialogue(
        context: context,
        message: "Are you sure you want to logout?",
        title: "Logout",
      )) {
        userController.setUser(null);
      }
    }

    return Obx(
      () => Row(
        children: <Widget>[
          appLogoWidget()
              .box
              .size(50, 50)
              .roundedFull
              .clip(Clip.antiAlias)
              .make(),
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
              child: (userController.isLoggedIn ? "Logout" : "Login")
                  .text
                  .white
                  .make())
        ],
      ),
    );
  }
}
