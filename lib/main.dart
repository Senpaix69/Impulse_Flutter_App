import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: whiteColor),
          backgroundColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(color: whiteColor),
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: const ColorScheme.light(
          primary: mehroonColor,
        ),
        fontFamily: regular,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}
