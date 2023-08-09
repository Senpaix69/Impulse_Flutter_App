import 'package:get/get.dart';

class SliderController extends GetxController {
  final List<RxInt> sliderIndices = List.generate(3, (index) => 0.obs);
  RxInt itemDetails = 0.obs;
}
