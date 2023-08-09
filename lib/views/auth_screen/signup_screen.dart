import 'dart:convert' show jsonDecode;
import 'package:impulse/consts/consts.dart';
import 'package:impulse/services/auth_service.dart';
import 'package:impulse/widget_common/applogo_widget.dart';
import 'package:impulse/widget_common/bg_widget.dart';
import 'package:impulse/widget_common/custom_button.dart';
import 'package:impulse/widget_common/custom_textfield.dart';
import 'package:impulse/widget_common/dialog_boxs.dart';
import 'package:impulse/widget_common/loading/loading_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  final loader = LoadingScreen.instance();
  bool checkbox = false;
  bool passVis = false;
  bool repassVis = false;

  final authService = AuthService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
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

  void signUpUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text.length < 6) {
        showError(
          message: "Required password of lenght 6 character at least",
          title: "Poor Password",
        );
        return;
      }
      if (_passwordController.text != _repasswordController.text) {
        showError(
          message: "Password did not match",
          title: "Confirm Password",
        );
        return;
      }

      if (checkbox) {
        loader.show(
          context: context,
          text: "Please wait...",
          title: "Signing-up",
        );

        try {
          Map<String, dynamic> result = await authService.signUpUser(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
          );

          loader.hide();
          if (result['status'] == 200) {
            showSnack(message: "User registered successfully");
            goBack();
            return;
          }
          showError(
              message: jsonDecode(result['body'])['msg'] ??
                  jsonDecode(result['body'])['error'] ??
                  jsonDecode(result['body']) ??
                  "A server error occured",
              title: "Error");
          return;
        } catch (e) {
          showError(message: e.toString(), title: "Error");
        }
      }
      showSnack(message: "Please agree to terms and conditions!");
    }
  }

  void goBack() => Navigator.of(context).pop();

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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        customTextField(
                          controller: _nameController,
                          hint: name,
                          hintText: nameHint,
                        ),
                        10.heightBox,
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
                        10.heightBox,
                        customTextField(
                          controller: _repasswordController,
                          hint: repassword,
                          obsecure: !repassVis,
                          hintText: passwordHint,
                          onPress: () => setState(() => repassVis = !repassVis),
                          suffixIcon: repassVis
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        5.heightBox,
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkbox,
                              onChanged: (value) {
                                setState(() => checkbox = value!);
                              },
                              activeColor: mehroonColor,
                              checkColor: whiteColor,
                            ),
                            10.widthBox,
                            Expanded(
                              child: RichText(
                                  text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey),
                                  ),
                                  TextSpan(
                                    text: termsAndConditions,
                                    style: TextStyle(
                                        fontFamily: regular,
                                        color: mehroonColor),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey),
                                  ),
                                  TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                        fontFamily: regular,
                                        color: mehroonColor),
                                  ),
                                ],
                              )),
                            ),
                          ],
                        ),
                        customButton(
                          onPress: signUpUser,
                          title: signup,
                          btnColor: mehroonColor,
                          textColor: whiteColor,
                        ).box.width(context.screenWidth - 50).make(),
                        10.heightBox,
                        RichText(
                            text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: alreadyHaveAcc,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey),
                            ),
                            TextSpan(
                              text: "? Login",
                              style: TextStyle(
                                  fontFamily: bold, color: mehroonColor),
                            ),
                          ],
                        )).onTap(goBack),
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
