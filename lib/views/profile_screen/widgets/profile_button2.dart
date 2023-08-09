import 'package:impulse/consts/consts.dart';

GestureDetector profileButton2({
  required IconData icon,
  required String title,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: <Widget>[
        Icon(icon),
        5.heightBox,
        title.text.size(14).white.make(),
      ],
    ),
  );
}
