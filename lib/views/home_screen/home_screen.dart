import 'package:impulse/consts/consts.dart';
import 'package:impulse/consts/lists.dart';
import 'package:impulse/widget_common/home_button.dart';
import 'package:impulse/widget_common/input_decoration.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: mehroonDark,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              alignment: Alignment.center,
              child: TextFormField(
                decoration: inputDecoration(
                  hintText: searchHint,
                  suffixIcon: Icons.search,
                ),
              ),
            ),
            VxSwiper.builder(
              autoPlay: true,
              height: 140,
              enlargeCenterPage: true,
              itemCount: sliderList.length,
              itemBuilder: (context, index) => Image.asset(
                sliderList[index],
                fit: BoxFit.fill,
              )
                  .box
                  .rounded
                  .clip(Clip.antiAlias)
                  .margin(const EdgeInsets.symmetric(horizontal: 8.0))
                  .make(),
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                2,
                (index) => Expanded(
                  child: homeButton(
                    title: index == 0 ? todayDeal : flashSale,
                    height: context.screenHeight * 0.15,
                    icon: index == 0 ? icTodaysDeal : icFlashDeal,
                    onPress: () {},
                  ),
                ),
              ),
            ),
            10.heightBox,
            VxSwiper.builder(
              autoPlay: true,
              height: 140,
              enlargeCenterPage: true,
              itemCount: sliderList2.length,
              itemBuilder: (context, index) => Image.asset(
                sliderList2[index],
                fit: BoxFit.fill,
              )
                  .box
                  .rounded
                  .clip(Clip.antiAlias)
                  .margin(const EdgeInsets.symmetric(horizontal: 8.0))
                  .make(),
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => Expanded(
                  child: homeButton(
                    title: index == 0
                        ? topCategory
                        : index == 1
                            ? topBrands
                            : topSeller,
                    height: context.screenHeight * 0.15,
                    icon: index == 0
                        ? icTopCategories
                        : index == 1
                            ? icBrands
                            : icTopSeller,
                    onPress: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
