import 'package:impulse/consts/consts.dart';

VxSwiper customSwiper({required List sliderList}) {
  return VxSwiper.builder(
    viewportFraction: 0.85,
    autoPlayAnimationDuration: const Duration(milliseconds: 500),
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
        .margin(const EdgeInsets.symmetric(horizontal: 4.0))
        .make(),
  );
}
