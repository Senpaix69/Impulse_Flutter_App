import 'dart:convert' show jsonDecode;
import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/route_controller/app_routes.dart';
import 'package:impulse/controllers/user_controller/user_controller.dart';
import 'package:impulse/models/user.dart';
import 'package:impulse/widget_common/applogo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final userController = Get.put(UserController(), permanent: true);
  late final Animation<Offset> _textAnimation;

  void changeScreen() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final user = sp.getString(userKey);
    await userController
        .setUser(user != null ? User.fromJson(jsonDecode(user)) : null);
    Future.delayed(
      const Duration(seconds: 3),
      () async => await Get.offNamed(AppRoutes.home),
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
          Opacity(
            opacity: 0.3,
            child: credits.text
                .color(whiteColor)
                .size(16)
                .fontFamily(semibold)
                .make(),
          ),
          30.heightBox,
        ],
      ),
    );
  }
}
