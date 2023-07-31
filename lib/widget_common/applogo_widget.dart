import 'package:impulse/consts/consts.dart';

Widget appLogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(100, 100)
      .padding(const EdgeInsets.all(6))
      .rounded
      .make();
}
