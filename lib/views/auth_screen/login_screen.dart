import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/consts/social_list.dart';
import 'package:impulse/views/auth_screen/signup_screen.dart';
import 'package:impulse/widget_common/applogo_widget.dart';
import 'package:impulse/widget_common/bg_widget.dart';
import 'package:impulse/widget_common/custom_button.dart';
import 'package:impulse/widget_common/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  customTextField(hint: email, hintText: emailHint),
                  10.heightBox,
                  customTextField(hint: password, hintText: passwordHint),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(forgetPassword),
                    ),
                  ),
                  customButton(
                    onPress: () {},
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
                  loginWith.text.color(fontGrey).fontFamily(semibold).make(),
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
