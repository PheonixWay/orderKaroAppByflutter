import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget homeButton({width, height, icon, String? titles, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      titles!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).make();
}
