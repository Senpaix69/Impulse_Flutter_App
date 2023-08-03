import 'package:impulse/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      child: "Cart is Empty".text.makeCentered().box.makeCentered(),
    );
  }
}
