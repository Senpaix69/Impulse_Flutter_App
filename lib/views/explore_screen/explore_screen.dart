import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/explore_controller.dart';
import 'package:impulse/controllers/home_controller.dart';
import 'package:impulse/views/explore_screen/widgets/categories_list.dart';
import 'package:impulse/widget_common/app_loading.dart';
import 'package:impulse/widget_common/bg_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final exploreController = Get.put(ExploreController());

    void goToHome() => controller.currentNavIndex.value = 0;

    Future<void> getRefresh() async =>
        await exploreController.fetchCategories();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: whiteColor),
            onPressed: goToHome,
          ),
          title: "Explore".text.color(whiteColor).fontFamily(semibold).make(),
        ),
        body: RefreshIndicator(
          onRefresh: getRefresh,
          child: Obx(
            () => exploreController.loading
                ? appLoading()
                : exploreController.catList.isEmpty
                    ? showEmptyMessage()
                    : showCategories(exploreController),
          ),
        ),
      ),
    );
  }
}
