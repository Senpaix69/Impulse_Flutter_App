import 'package:impulse/consts/consts.dart';

Widget customTextField({
  required String hint,
  String? hintText,
  IconData? suffixIcon,
  bool obsecure = false,
  Function()? onPress,
  TextEditingController? controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      hint.text.color(mehroonColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: obsecure,
        controller: controller,
        decoration: InputDecoration(
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
        ),
      ),
    ],
  );
}
