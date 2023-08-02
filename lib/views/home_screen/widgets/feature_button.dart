import 'package:impulse/consts/consts.dart';

Widget featureButton({
  required String img,
  required String title,
}) {
  return Row(
    children: <Widget>[
      Image.asset(
        img,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4.0))
      .white
      .rounded
      .shadowSm
      .padding(const EdgeInsets.all(10))
      .make();
}
