import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/home_controller/home_controller.dart';
import 'package:impulse/views/cart_screen/cart_screen.dart';
import 'package:impulse/views/category_screen/category_screen.dart';
import 'package:impulse/views/home_screen/home_screen.dart';
import 'package:impulse/views/profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    final navItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: "Category"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: "Profile"),
    ];

    final navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Column(children: <Widget>[
        Obx(() => Expanded(
            child: navBody.elementAt(controller.currentNavIndex.value))),
      ]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          onTap: (value) => controller.currentNavIndex.value = value,
          selectedLabelStyle: const TextStyle(fontFamily: bold),
          items: navItems,
          backgroundColor: whiteColor,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
