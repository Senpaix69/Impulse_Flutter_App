import 'package:flutter/material.dart';
import 'package:impulse/widget_common/home_button.dart';

Row buttonsList(
    {required double height, required List btnsText, required List icons}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(
      btnsText.length,
      (index) => Expanded(
        child: homeButton(
          title: btnsText[index],
          height: height * 0.15,
          icon: icons[index],
          onPress: () {},
        ),
      ),
    ),
  );
}
