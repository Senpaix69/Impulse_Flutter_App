import 'package:impulse/consts/consts.dart';

InputDecoration inputDecoration({
  IconData? suffixIcon,
  Function()? onPress,
  String? hintText,
}) {
  return InputDecoration(
    suffixIcon: IconButton(
      icon: Icon(suffixIcon),
      onPressed: onPress,
    ),
    contentPadding: const EdgeInsets.all(12),
    hintStyle: const TextStyle(
      fontFamily: semibold,
      color: fontGrey,
    ),
    hintText: hintText,
    isDense: true,
    fillColor: lightGrey,
    filled: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: mehroonColor),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );
}
