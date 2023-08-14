import 'package:impulse/consts/consts.dart';
import 'package:impulse/models/sub_category.dart';

SingleChildScrollView subCategories(
    {required List<SubCategory> subcategories}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
          subcategories.length,
          (index) => subcategories[index]
              .title
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
