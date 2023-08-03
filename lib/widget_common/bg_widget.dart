import 'package:impulse/consts/consts.dart';

Widget bgWidget({Widget? child, String? background}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(background ?? imgBackground),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
