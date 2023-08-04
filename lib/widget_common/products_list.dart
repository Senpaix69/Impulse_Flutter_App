import 'package:impulse/consts/consts.dart';

Container productLists(
    {required String title,
    Color? color = mehroonColor,
    Color? titleColor = whiteColor}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    color: color,
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title.text.size(16).color(titleColor).fontFamily(bold).make(),
        10.heightBox,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              6,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    imgP1,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  5.heightBox,
                  "Laptop 4GB/64GB"
                      .text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .make(),
                  5.heightBox,
                  "\$600"
                      .text
                      .color(mehroonColor)
                      .fontFamily(bold)
                      .size(16)
                      .make()
                ],
              )
                  .box
                  .white
                  .padding(const EdgeInsets.all(10.0))
                  .margin(const EdgeInsets.only(right: 8.0))
                  .rounded
                  .make(),
            ),
          ),
        ),
      ],
    ),
  );
}
