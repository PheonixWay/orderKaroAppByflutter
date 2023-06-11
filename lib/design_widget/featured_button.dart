import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget featuredButton({String? titles, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      5.widthBox,
      titles!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .roundedSM
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .outerShadowSm
      .make();
}
