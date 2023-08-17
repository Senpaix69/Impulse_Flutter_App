import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/explore_controller.dart';
import 'package:impulse/views/explore_screen/category_details.dart';

Container showCategories(ExploreController exploreController) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
    child: GridView.builder(
      shrinkWrap: true,
      itemCount: exploreController.catList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        mainAxisExtent: 190,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) => Column(
        children: <Widget>[
          FadeInImage(
            placeholder: const AssetImage(placeholder),
            image: NetworkImage(exploreController.catList[index].imageUrl),
            height: 120,
            width: 200,
            fit: BoxFit.cover,
          ),
          10.heightBox,
          exploreController.catList[index].title.text
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
                title: exploreController.catList[index].title,
                id: exploreController.catList[index].id,
              ),
            ),
          ),
    ),
  );
}
