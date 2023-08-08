import 'package:get/get.dart';
import 'package:impulse/views/auth_screen/login_screen.dart';
import 'package:impulse/views/auth_screen/signup_screen.dart';
import 'package:impulse/views/home_screen/home.dart';
import 'package:impulse/views/home_screen/home_screen.dart';
import 'package:impulse/views/profile_screen/profile_screen.dart';
import 'package:impulse/views/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "/";
  static const String home = "/home";
  static const String homeScreen = "/homeScreen";
  static const String loginScreen = "/login";
  static const String signUpScreen = "/signin";
  static const String profileScreen = "/profile";
  static final List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const Home()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: signUpScreen, page: () => const SignupScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
  ];
}
