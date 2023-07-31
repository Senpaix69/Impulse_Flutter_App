import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/views/auth_screen/login_screen.dart';
import 'package:impulse/widget_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.to(() => const LoginScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mehroonColor,
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              icSplashBg,
              width: 300,
            ),
          ),
          20.heightBox,
          appLogoWidget(),
          10.heightBox,
          appname.text.color(whiteColor).size(20).fontFamily(bold).make(),
          const Spacer(),
          credits.text.color(whiteColor).size(16).fontFamily(bold).make(),
          20.heightBox,
        ],
      ),
    );
  }
}
