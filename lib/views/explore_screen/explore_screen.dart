import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/home_controller/home_controller.dart';
import 'package:impulse/views/explore_screen/category_details.dart';
import 'package:impulse/widget_common/bg_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    void goToHome() {
      controller.currentNavIndex.value = 0;
    }

    return WillPopScope(
      onWillPop: () async {
        goToHome();
        return false;
      },
      child: bgWidget(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: whiteColor),
              onPressed: goToHome,
            ),
            title: "Explore".text.color(whiteColor).fontFamily(semibold).make(),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                mainAxisExtent: 190,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  Image.asset(
                    categoriesListImgs[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoriesList[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make(),
                ],
              )
                  .box
                  .white
                  .roundedSM
                  .padding(const EdgeInsets.all(6))
                  .outerShadowSm
                  .clip(Clip.antiAlias)
                  .make()
                  .onTap(
                    () => Get.to(
                      () => CategoryDetails(title: categoriesList[index]),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
