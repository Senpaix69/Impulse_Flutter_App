import 'package:impulse/consts/consts.dart';

void showSnackbar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: mehroonColor,
      content: Text(
        message,
        style: const TextStyle(
          color: lightGrey,
        ),
      ),
    ),
  );
}
