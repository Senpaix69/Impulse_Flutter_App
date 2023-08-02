import 'package:impulse/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imgBackground),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
