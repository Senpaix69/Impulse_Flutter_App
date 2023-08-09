import 'package:impulse/consts/consts.dart';
import 'package:impulse/widget_common/input_decoration.dart';

Widget customTextField({
  required String hint,
  String? hintText,
  IconData? suffixIcon,
  bool obsecure = false,
  Function()? onPress,
  Function(String)? onChange,
  bool? enabled,
  TextEditingController? controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      hint.text.color(mehroonColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        onChanged: onChange,
        enabled: enabled,
        obscureText: obsecure,
        controller: controller,
        decoration: inputDecoration(
          suffixIcon: suffixIcon,
          onPress: onPress,
          hintText: hintText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $hintText";
          }
          return null;
        },
      ),
    ],
  );
}
