import 'package:impulse/consts/consts.dart';
import 'package:impulse/consts/lists.dart';
import 'package:impulse/views/home_screen/widgets/buttons_list.dart';
import 'package:impulse/views/home_screen/widgets/custom_swiper.dart';
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
        ],
      ),
    );
  }
}
