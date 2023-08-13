import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/home_controller.dart';
import 'package:impulse/models/category.dart';
import 'package:impulse/services/explore_service.dart';
import 'package:impulse/views/explore_screen/category_details.dart';
import 'package:impulse/widget_common/bg_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final exploreService = ExploreService();

    void goToHome() => controller.currentNavIndex.value = 0;

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: whiteColor),
            onPressed: goToHome,
          ),
          title: "Explore".text.color(whiteColor).fontFamily(semibold).make(),
        ),
        body: FutureBuilder<List<Category>>(
          future: exploreService.getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active) {
              return circularIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: "Network Connection Error"
                    .text
                    .size(18)
                    .color(darkFontGrey)
                    .make(),
              );
            } else if (snapshot.hasData) {
              final List<Category> categories = snapshot.data ?? [];
              return Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    mainAxisExtent: 190,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      FadeInImage(
                        placeholder: const AssetImage(placeholder1),
                        image: NetworkImage(categories[index].imageUrl),
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      10.heightBox,
                      categories[index]
                          .title
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
                      .outerShadow
                      .clip(Clip.antiAlias)
                      .make()
                      .onTap(
                        () => Get.to(
                          () => CategoryDetails(
                            title: categories[index].title,
                            id: categories[index].id,
                          ),
                        ),
                      ),
                ),
              );
            } else {
              return circularIndicator();
            }
          },
        ),
      ),
    );
  }

  Center circularIndicator() =>
      const Center(child: CircularProgressIndicator(color: mehroonColor));
}
