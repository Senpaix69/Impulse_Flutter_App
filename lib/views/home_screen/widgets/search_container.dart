import 'package:impulse/consts/consts.dart';

Container searchContainer() {
  return Container(
    color: whiteColor,
    height: 40,
    alignment: Alignment.center,
    child: Row(
      children: <Widget>[
        Image.asset(
          icAppLogo,
          height: 30,
        ),
        10.widthBox,
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
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
  );
}
