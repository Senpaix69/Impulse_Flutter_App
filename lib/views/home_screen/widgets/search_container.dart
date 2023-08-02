import 'package:impulse/consts/consts.dart';
import 'package:impulse/widget_common/applogo_widget.dart';

Widget searchContainer() {
  return SafeArea(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 40,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          appLogoWidget().box.width(50).make(),
          10.widthBox,
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.all(12),
                suffixIcon: const Icon(
                  Icons.search,
                  color: fontGrey,
                ),
                hintText: searchHint,
                hintStyle: const TextStyle(fontFamily: regular),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: lightGrey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
