import 'package:impulse/consts/consts.dart';
import 'package:impulse/widget_common/input_decoration.dart';

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
        decoration: inputDecoration(
          suffixIcon: suffixIcon,
          onPress: onPress,
          hintText: hintText,
        ),
      ),
    ],
  );
}
