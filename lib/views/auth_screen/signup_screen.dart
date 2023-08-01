import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/widget_common/applogo_widget.dart';
import 'package:impulse/widget_common/bg_widget.dart';
import 'package:impulse/widget_common/custom_button.dart';
import 'package:impulse/widget_common/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              20.heightBox,
              Column(
                children: <Widget>[
                  customTextField(hint: name, hintText: nameHint),
                  10.heightBox,
                  customTextField(hint: email, hintText: emailHint),
                  10.heightBox,
                  customTextField(hint: password, hintText: passwordHint),
                  10.heightBox,
                  customTextField(hint: repassword, hintText: passwordHint),
                  5.heightBox,
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                        checkColor: mehroonColor,
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
                        style: TextStyle(fontFamily: bold, color: mehroonColor),
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
      ).onTap(() {
        if (FocusScope.of(context).hasPrimaryFocus) {
          FocusScope.of(context).unfocus();
        }
      }),
    );
  }
}
