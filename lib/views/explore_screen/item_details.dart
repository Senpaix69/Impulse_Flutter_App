import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/views/explore_screen/widgets/action_button.dart';
import 'package:impulse/views/explore_screen/widgets/color_quantity.dart';
import 'package:impulse/views/explore_screen/widgets/items_swiper.dart';
import 'package:impulse/widget_common/custom_button.dart';
import 'package:impulse/widget_common/products_list.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  const ItemDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: whiteColor,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const CustomSwiper(sliderList: itemDetailsImg),
                  10.heightBox,
                  itemTitleAndRating().box.white.outerShadow.p16.make(),
                  saleType().box.p12.color(lightGrey).make(),
                  const ColorAndQuantity(),
                  20.heightBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      description.text.fontFamily(bold).size(16).make(),
                      5.heightBox,
                      descriptionList.text.make(),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16))
                      .white
                      .outerShadow
                      .make(),
                  itemButtons().box.p12.make(),
                  10.heightBox,
                  productLists(
                    title: sugProd,
                    color: whiteColor,
                    titleColor: mehroonColor,
                  ),
                  40.heightBox,
                ],
              ).box.p4.white.make(),
            ),
            bottomActions(),
          ],
        ),
      ),
    );
  }

  Column itemButtons() {
    return Column(
      children: List.generate(
        itemsBtnList.length,
        (index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            itemsBtnList[index].text.fontFamily(bold).make(),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black,
            ),
          ],
        ).box.py12.make(),
      ),
    );
  }

  Row saleType() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            "Sale".text.color(darkFontGrey).make(),
            "In House Product".text.color(darkFontGrey).make(),
          ],
        ),
        const Spacer(),
        const Icon(
          Icons.message,
          color: Colors.black,
        ).box.white.p8.size(50, 50).roundedFull.make(),
      ],
    );
  }

  Column itemTitleAndRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
        10.heightBox,
        VxRating(onRatingUpdate: (value) {}),
        10.heightBox,
        "\$35,000".text.fontFamily(bold).color(mehroonColor).size(16).make(),
        10.heightBox,
      ],
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: whiteColor,
      actions: <Widget>[
        actionbutton(onClick: () {}, icon: const Icon(Icons.share)),
        actionbutton(
          onClick: () {},
          icon: Image.asset(
            icHeart,
            width: 25,
          ),
        ).marginOnly(right: 5),
      ],
    );
  }

  Align bottomActions() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: <Widget>[
          Expanded(
            child: customButton(
              onPress: () {},
              title: "Add to cart",
              textColor: whiteColor,
              btnColor: mehroonColor,
              padding: (10, 12),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: customButton(
              onPress: () {},
              title: "Buy now",
              textColor: mehroonColor,
              btnColor: lightGolden,
              padding: (10, 12),
            ),
          ),
        ],
      ).box.white.make(),
    );
  }
}
