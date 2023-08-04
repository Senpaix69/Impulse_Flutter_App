import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/home_controller/home_controller.dart';
import 'package:impulse/views/cart_screen/cart_screen.dart';
import 'package:impulse/views/deals_screen/deals_screen.dart';
import 'package:impulse/views/explore_screen/explore_screen.dart';
import 'package:impulse/views/home_screen/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:impulse/views/profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    final navItems = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 26,
          ),
          label: "Home"),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.travel_explore,
            size: 26,
          ),
          label: "Explore"),
      const BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.tag,
            size: 23,
          ),
          label: "Deals"),
      const BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.cartShopping,
            size: 23,
          ),
          label: "Cart"),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 26,
          ),
          label: "Profile"),
    ];

    final navBody = [
      const HomeScreen(),
      const ExploreScreen(),
      const DealsScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Obx(() => Expanded(child: navBody[controller.currentNavIndex.value])),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          onTap: (value) => controller.currentNavIndex.value = value,
          selectedLabelStyle: const TextStyle(fontFamily: bold),
          items: navItems,
          selectedItemColor: whiteColor,
          unselectedItemColor: const Color.fromARGB(130, 255, 255, 255),
          backgroundColor: mehroonColor,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
