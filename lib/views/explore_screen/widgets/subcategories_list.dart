import 'package:impulse/consts/consts.dart';

SingleChildScrollView subCategories({required int childCount}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
          childCount,
          (index) => "Baby Clothing"
              .text
              .size(12)
              .fontFamily(semibold)
              .color(darkFontGrey)
              .makeCentered()
              .box
              .white
              .roundedSM
              .size(120, 60)
              .margin(const EdgeInsets.symmetric(horizontal: 4.0))
              .make()),
    ),
  );
}
