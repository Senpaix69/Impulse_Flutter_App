import 'package:impulse/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        colorFilter: ColorFilter.mode(mehroonColor, BlendMode.color),
        image: AssetImage(imgBackground),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
