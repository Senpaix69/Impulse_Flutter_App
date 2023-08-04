import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/views/explore_screen/widgets/action_button.dart';
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
                  itemTitleAndRating().box.white.shadowSm.p16.make(),
                  saleType().box.p12.color(lightGrey).make(),
                  colorAndQuantity(context).box.shadowSm.py16.white.make(),
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
                      .shadowSm
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
              ).box.shadowSm.p4.white.make(),
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

  Column colorAndQuantity(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            "Color".text.color(darkFontGrey).make().marginOnly(left: 10),
            (context.screenWidth / 5).widthBox,
            Row(
              children: List.generate(
                3,
                (index) => VxBox()
                    .size(35, 35)
                    .color(Vx.randomPrimaryColor)
                    .margin(
                      const EdgeInsets.symmetric(horizontal: 6.0),
                    )
                    .roundedFull
                    .make(),
              ),
            ),
          ],
        ),
        10.heightBox,
        Row(
          children: <Widget>[
            "Quantity".text.color(darkFontGrey).make().marginOnly(left: 10),
            (context.screenWidth / 8).widthBox,
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
            10.widthBox,
            "0".text.size(16).color(darkFontGrey).make(),
            10.widthBox,
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            "50 Available".text.color(darkFontGrey).make(),
          ],
        ),
        10.heightBox,
        Row(
          children: <Widget>[
            "Total Amount".text.color(darkFontGrey).make().marginOnly(left: 10),
            (context.screenWidth / 11).widthBox,
            "\$0.00".text.size(16).fontFamily(bold).color(mehroonColor).make(),
          ],
        ).box.color(lightGolden).py12.make(),
      ],
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
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: customButton(
              onPress: () {},
              title: "Buy now",
              textColor: mehroonColor,
              btnColor: lightGolden,
            ),
          ),
        ],
      ).box.white.make(),
    );
  }
}
