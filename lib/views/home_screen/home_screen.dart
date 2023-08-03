import 'package:impulse/consts/consts.dart';
import 'package:impulse/views/home_screen/widgets/buttons_list.dart';
import 'package:impulse/views/home_screen/widgets/custom_swiper.dart';
import 'package:impulse/views/home_screen/widgets/feature_button.dart';
import 'package:impulse/views/home_screen/widgets/search_container.dart';
import 'package:impulse/widget_common/bg_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Column(
        children: <Widget>[
          searchContainer(),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  customSwiper(sliderList: sliderList),
                  10.heightBox,
                  buttonsList(
                    height: context.screenHeight,
                    btnsText: [todayDeal, flashSale],
                    icons: [icTodaysDeal, icFlashDeal],
                  ),
                  10.heightBox,
                  customSwiper(sliderList: sliderList2),
                  10.heightBox,
                  buttonsList(
                    height: context.screenHeight,
                    btnsText: [topCategory, topBrands, topSeller],
                    icons: [icTopCategories, icBrands, icTopSeller],
                  ),
                  10.heightBox,
                  featuredCategoriesList(),
                  featuredProductsList(),
                  10.heightBox,
                  customSwiper(sliderList: sliderList2),
                  10.heightBox,
                  allProductsLists(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container allProductsLists() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      color: lightGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          allProducts.text.size(18).color(mehroonColor).fontFamily(bold).make(),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              mainAxisExtent: 300.0,
            ),
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  imgP5,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const Spacer(),
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
            ).box.white.padding(const EdgeInsets.all(12.0)).roundedSM.make(),
          ),
        ],
      ),
    );
  }

  Container featuredProductsList() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: mehroonColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          featuredProducts.text
              .size(16)
              .color(whiteColor)
              .fontFamily(bold)
              .make(),
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

  Container featuredCategoriesList() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: lightGrey,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: featuredCategories.text
                .fontFamily(bold)
                .size(16)
                .color(darkFontGrey)
                .make(),
          ),
          10.heightBox,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Column(
                  children: <Widget>[
                    featureButton(
                        img: featuredListImg1[index],
                        title: featuredListTitles1[index]),
                    10.heightBox,
                    featureButton(
                        img: featuredListImg2[index],
                        title: featuredListTitles2[index]),
                    10.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
