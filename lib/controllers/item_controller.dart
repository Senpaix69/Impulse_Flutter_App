import 'package:get/get.dart';

class ItemController extends GetxController {
  RxInt quantity = 0.obs;
  RxInt selectedColor = 0.obs;
  RxBool showMoreDesc = false.obs;

  bool get show => showMoreDesc.value;
  void toggleHeight() => showMoreDesc.value = !showMoreDesc.value;
}
