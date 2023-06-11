import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget appLogoWidget() {
  // using velocityt desining it
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
