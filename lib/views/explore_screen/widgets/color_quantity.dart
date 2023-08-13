import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/item_controller.dart';

enum QuantityActions {
  add,
  remove,
}

class ColorAndQuantity extends StatelessWidget {
  final List<String> colors;
  final double price;
  final int available;
  const ColorAndQuantity({
    Key? key,
    required this.colors,
    required this.price,
    required this.available,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemController());

    void setQuantity(QuantityActions action) {
      int val = controller.quantity.value;
      switch (action) {
        case QuantityActions.add:
          val += 1;
          if (val > available) {
            return;
          }
          controller.quantity.value = val;
          break;
        case QuantityActions.remove:
          val -= 1;
          if (val < 0) {
            return;
          }
          controller.quantity.value = val;
      }
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            "Color".text.color(darkFontGrey).make().marginOnly(left: 10),
            (context.screenWidth / 5).widthBox,
            Obx(
              () => Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      colors.length,
                      (index) => VxBox(
                              child: index == controller.selectedColor.value
                                  ? const Icon(Icons.check)
                                  : null)
                          .size(35, 35)
                          .color(Color(int.parse(colors[index])))
                          .margin(
                            const EdgeInsets.symmetric(horizontal: 6.0),
                          )
                          .roundedFull
                          .make()
                          .onTap(() => controller.selectedColor.value = index),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            "Quantity".text.color(darkFontGrey).make(),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => setQuantity(QuantityActions.remove),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                ),
                10.widthBox,
                Obx(() => controller.quantity.value.text
                    .size(16)
                    .color(darkFontGrey)
                    .make()),
                10.widthBox,
                IconButton(
                  onPressed: () => setQuantity(QuantityActions.add),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            "$available Available"
                .text
                .color(darkFontGrey)
                .overflow(TextOverflow.ellipsis)
                .make(),
          ],
        ).marginSymmetric(horizontal: 10.0),
        10.heightBox,
        Row(
          children: <Widget>[
            "Total Amount".text.color(darkFontGrey).make().marginOnly(left: 10),
            (context.screenWidth / 11).widthBox,
            Obx(() => ("\$${controller.quantity.value * price}")
                .text
                .size(16)
                .fontFamily(bold)
                .color(mehroonColor)
                .make()),
          ],
        ).box.color(lightGolden).py12.make(),
      ],
    ).box.outerShadow.py16.white.make();
  }
}
