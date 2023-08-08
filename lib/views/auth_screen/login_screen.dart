import 'dart:convert';
import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/route_controller/app_routes.dart';
import 'package:impulse/controllers/user_controller/user_controller.dart';
import 'package:impulse/models/user.dart';
import 'package:impulse/services/auth_service.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authService = AuthService();
  final userController = Get.put(UserController());
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
        final data = jsonDecode(response['body'])['msg'];
        final user = User(
            id: data['_id'],
            name: data['name'],
            email: data['email'],
            password: data['password'],
            address: data['password'],
            type: data['type'],
            token: "");
        userController.setUser(user);
        await Get.offNamed(AppRoutes.home);
        return;
      }
      showError(
        message: jsonDecode(response['body'])['msg'] ??
            jsonDecode(response['body'])['error'] ??
            "An Error Occured",
        title: "Error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                (context.screenHeight * 0.07).heightBox,
                appLogoWidget(),
                20.heightBox,
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        onPress: () => Get.toNamed(AppRoutes.signUpScreen),
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
    );
  }
}
