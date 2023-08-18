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
              .size(14)
              .overflow(TextOverflow.ellipsis)
              .fontFamily(semibold)
              .color(darkFontGrey)
              .makeCentered()
              .box
              .white
              .roundedSM
              .height(40)
              .withConstraints(const BoxConstraints(minWidth: 100))
              .padding(const EdgeInsets.symmetric(horizontal: 10.0))
              .margin(const EdgeInsets.symmetric(horizontal: 4.0))
              .make()),
    ),
  );
}
