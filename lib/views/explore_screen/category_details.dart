import 'package:impulse/consts/consts.dart';
import 'package:impulse/views/explore_screen/widgets/subcategories_list.dart';
import 'package:impulse/widget_common/bg_widget.dart';

class CategoryDetails extends StatelessWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title.text
              .fontFamily(bold)
              .white
              .overflow(TextOverflow.ellipsis)
              .make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              subCategories(childCount: 6),
              20.heightBox,
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    mainAxisExtent: 250.0,
                  ),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        imgP5,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      const Spacer(),
                      "Laptop 4GB/64GB"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      5.heightBox,
                      "\$600"
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
                      .make(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
