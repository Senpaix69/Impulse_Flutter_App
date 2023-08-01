import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/views/auth_screen/controller/password_controller.dart';
import 'package:impulse/widget_common/applogo_widget.dart';
import 'package:impulse/widget_common/bg_widget.dart';
import 'package:impulse/widget_common/custom_button.dart';
import 'package:impulse/widget_common/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordController());
    return bgWidget(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  (context.screenHeight * 0.08).heightBox,
                  appLogoWidget(),
                  20.heightBox,
                  Column(
                    children: <Widget>[
                      customTextField(hint: name, hintText: nameHint),
                      10.heightBox,
                      customTextField(hint: email, hintText: emailHint),
                      10.heightBox,
                      Obx(
                        () => customTextField(
                          hint: password,
                          obsecure: !controller.password.value,
                          hintText: passwordHint,
                          onPress: () => controller.password.value =
                              !controller.password.value,
                          suffixIcon: controller.password.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      10.heightBox,
                      Obx(
                        () => customTextField(
                          hint: repassword,
                          obsecure: !controller.repassword.value,
                          hintText: passwordHint,
                          onPress: () => controller.repassword.value =
                              !controller.repassword.value,
                          suffixIcon: controller.repassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      5.heightBox,
                      Row(
                        children: <Widget>[
                          Obx(
                            () => Checkbox(
                              value: controller.checkbox.value,
                              onChanged: (value) {
                                controller.checkbox.value = value!;
                              },
                              activeColor: mehroonColor,
                              checkColor: whiteColor,
                            ),
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
                                      fontFamily: regular, color: mehroonColor),
                                ),
                                TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                      fontFamily: regular, color: fontGrey),
                                ),
                                TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                      fontFamily: regular, color: mehroonColor),
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                      customButton(
                        onPress: () {},
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
                            style: TextStyle(fontFamily: bold, color: fontGrey),
                          ),
                          TextSpan(
                            text: "? Login",
                            style: TextStyle(
                                fontFamily: bold, color: mehroonColor),
                          ),
                        ],
                      )).onTap(() => Get.back()),
                    ],
                  )
                      .box
                      .color(whiteColor)
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 50)
                      .shadowSm
                      .make(),
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
