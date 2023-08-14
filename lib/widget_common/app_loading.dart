import 'package:impulse/consts/consts.dart';
import 'package:impulse/widget_common/applogo_widget.dart';

Widget appLoading() {
  return Center(
    child: Stack(
      children: <Widget>[
        appLogoWidget()
            .box
            .roundedFull
            .clip(Clip.antiAlias)
            .size(50, 50)
            .make(),
        const SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: mehroonColor,
          ),
        )
      ],
    ),
  );
}
