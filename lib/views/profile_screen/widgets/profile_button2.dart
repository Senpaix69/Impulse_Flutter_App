import 'package:impulse/consts/consts.dart';

Column profileButton2({
  required IconData icon,
  required String title,
}) {
  return Column(
    children: <Widget>[
      Icon(icon),
      5.heightBox,
      title.text.size(14).white.make(),
    ],
  );
}
