import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/views/auth_screen/login_screen.dart';
import 'package:impulse/widget_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _textAnimation;

  void changeScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.off(() => const LoginScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ),
    );
    _textAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward(from: 0.0);
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          FadeTransition(
            opacity: _animationController,
            child: Column(
              children: <Widget>[
                appLogoWidget(),
                10.heightBox,
                SlideTransition(
                  position: _textAnimation,
                  child: appname.text
                      .color(whiteColor)
                      .size(20)
                      .fontFamily(bold)
                      .make(),
                ),
              ],
            ),
          ),
          const Spacer(),
          credits.text.color(whiteColor).size(16).fontFamily(bold).make(),
          20.heightBox,
        ],
      ),
    );
  }
}
