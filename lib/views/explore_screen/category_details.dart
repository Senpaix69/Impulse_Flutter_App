import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/models/item.dart';
import 'package:impulse/models/sub_category.dart';
import 'package:impulse/services/explore_service.dart';
import 'package:impulse/services/item_service.dart';
import 'package:impulse/views/explore_screen/item_details.dart';
import 'package:impulse/views/explore_screen/widgets/subcategories_list.dart';
import 'package:impulse/widget_common/app_loading.dart';
import 'package:impulse/widget_common/bg_widget.dart';

class CategoryDetails extends StatelessWidget {
  final String title;
  final String id;
  const CategoryDetails({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    final exploreService = ExploreService();
    final itemService = ItemService();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title.text
              .fontFamily(semibold)
              .white
              .overflow(TextOverflow.ellipsis)
              .make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder<List<SubCategory>>(
                future: exploreService.getSubCategories(id: id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.active) {
                    return const SizedBox();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: snapshot.error
                          .toString()
                          .text
                          .size(18)
                          .color(whiteColor)
                          .make(),
                    );
                  }
                  if (snapshot.hasData) {
                    final subcat = snapshot.data;
                    return subCategories(subcategories: subcat ?? []);
                  }
                  return const SizedBox();
                },
              ),
              20.heightBox,
              Expanded(
                child: FutureBuilder<List<Item>>(
                  future: itemService.getAllItems(categoryId: id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.active) {
                      return appLoading();
                    }
                    if (snapshot.hasError) {
                      return errorMessage(text: snapshot.error.toString());
                    }
                    if (snapshot.hasData) {
                      final listItems = snapshot.data ?? [];
                      if (listItems.isEmpty) {
                        return showEmptyMessage();
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: listItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          mainAxisExtent: 250.0,
                        ),
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FadeInImage(
                              placeholder: const AssetImage(placeholder),
                              image: NetworkImage(listItems[index].image),
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            listItems[index]
                                .title
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            VxRating(
                              onRatingUpdate: (value) {},
                              maxRating: 5.0,
                              value: listItems[index].rating,
                              isSelectable: false,
                            ),
                            '\$${listItems[index].price}'
                                .text
                                .color(mehroonColor)
                                .fontFamily(bold)
                                .size(16)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .padding(const EdgeInsets.all(12.0))
                            .roundedSM
                            .make()
                            .onTap(
                              () => Get.to(
                                () => ItemDetails(
                                  itemId: listItems[index].itemId,
                                ),
                              ),
                            ),
                      );
                    }
                    return appLoading();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
