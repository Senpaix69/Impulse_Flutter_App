import 'dart:convert';

import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/services/auth_service.dart';
import 'package:impulse/views/auth_screen/signup_screen.dart';
import 'package:impulse/views/home_screen/home.dart';
import 'package:impulse/widget_common/applogo_widget.dart';
import 'package:impulse/widget_common/bg_widget.dart';
import 'package:impulse/widget_common/custom_button.dart';
import 'package:impulse/widget_common/custom_textfield.dart';
import 'package:impulse/widget_common/dialog_boxs.dart';
import 'package:impulse/widget_common/loading/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  final authService = AuthService();
  final loader = LoadingScreen.instance();
  bool passVis = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showSnack({required String message}) => showSnackbar(
        context: context,
        message: message,
      );

  void showError({required String message, required String title}) =>
      errorDialogue(
        context: context,
        message: message,
        title: title,
      );

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      loader.show(context: context, text: "Please wait...", title: "Login-in");
      final response = await authService.signInUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      loader.hide();
      if (response['status'] == 200) {
        Get.offAll(() => const Home());
        return;
      }
      showError(
          message: jsonDecode(response['body'])['msg'] ??
              jsonDecode(response['body'])['error'] ??
              "An Error Occured",
          title: "Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  (context.screenHeight * 0.07).heightBox,
                  appLogoWidget(),
                  20.heightBox,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        customTextField(
                          controller: _emailController,
                          hint: email,
                          hintText: emailHint,
                        ),
                        10.heightBox,
                        customTextField(
                          controller: _passwordController,
                          hint: password,
                          obsecure: !passVis,
                          hintText: passwordHint,
                          onPress: () => setState(() => passVis = !passVis),
                          suffixIcon:
                              passVis ? Icons.visibility : Icons.visibility_off,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(forgetPassword),
                          ),
                        ),
                        customButton(
                          onPress: loginUser,
                          title: login,
                          btnColor: mehroonColor,
                          textColor: whiteColor,
                        ).box.width(context.screenWidth - 50).make(),
                        5.heightBox,
                        createNewAccount.text
                            .color(fontGrey)
                            .fontFamily(semibold)
                            .make(),
                        5.heightBox,
                        customButton(
                          onPress: () => Get.to(() => const SignupScreen()),
                          title: signup,
                          btnColor: lightGolden,
                          textColor: mehroonColor,
                        ).box.width(context.screenWidth - 50).make(),
                        5.heightBox,
                        loginWith.text
                            .color(fontGrey)
                            .fontFamily(semibold)
                            .make(),
                        5.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        .box
                        .color(whiteColor)
                        .rounded
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 50)
                        .shadowSm
                        .make(),
                  ),
                ],
              ),
            ),
          ).onTap(() {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }),
        ),
      ),
    );
  }
}
