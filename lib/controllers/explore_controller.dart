import 'package:get/get.dart';
import 'package:impulse/models/category.dart';
import 'package:impulse/services/explore_service.dart';

class ExploreController extends GetxController {
  final exploreService = ExploreService();
  RxBool isLoading = false.obs;
  RxList<Category> catList = <Category>[].obs;

  ExploreController() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    catList.value = await exploreService.getAllCategories();
    isLoading.value = false;
  }

  bool get loading => isLoading.value;

  List<Category> get categories => catList;
}
