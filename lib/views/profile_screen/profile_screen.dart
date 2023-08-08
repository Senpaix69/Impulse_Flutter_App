import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/home_controller/home_controller.dart';
import 'package:impulse/views/profile_screen/widgets/profile_button.dart';
import 'package:impulse/views/profile_screen/widgets/profile_button2.dart';
import 'package:impulse/views/profile_screen/widgets/user_details.dart';
import 'package:impulse/widget_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return WillPopScope(
      onWillPop: () async {
        controller.currentNavIndex.value = 0;
        return false;
      },
      child: bgWidget(
        background: imgBackgroundHalf,
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const UserDetails(),
                20.heightBox,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        profileButtons(),
                        20.heightBox,
                        profileTiles(),
                        20.heightBox,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container profileTiles() {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Row(
          children: <Widget>[
            Image.asset(listTilesIcons[index], width: 20),
            16.widthBox,
            listTiles[index].text.fontFamily(semibold).make(),
          ],
        )
            .box
            .padding(const EdgeInsets.symmetric(vertical: 12, horizontal: 16.0))
            .width(context.screenWidth)
            .make(),
        separatorBuilder: (context, index) => const Divider(
          color: lightGrey,
        ),
        itemCount: listTiles.length,
      ).box.roundedSM.white.px8.shadowSm.py12.make(),
    );
  }

  Column profileButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            profileButton(count: 00, title: "In your cart"),
            10.widthBox,
            profileButton(count: 22, title: "In your wishlist"),
            10.widthBox,
            profileButton(count: 3037, title: "You ordered"),
          ],
        ),
        16.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            profileButton2(
              icon: Icons.language_rounded,
              title: "Language",
            ),
            10.widthBox,
            profileButton2(
              icon: Icons.mode_edit,
              title: "Edit Profile",
            ),
            10.widthBox,
            profileButton2(
              icon: Icons.location_on,
              title: "Address",
            ),
          ],
        ),
      ],
    );
  }
}
