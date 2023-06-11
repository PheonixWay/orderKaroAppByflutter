import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget detailsCard({width, String? title, String? count}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.make(),
      5.heightBox,
      title!.text.make(),
    ],
  )
      .box
      .white
      .roundedSM
      .width(width)
      .height(75)
      .padding(const EdgeInsets.all(10))
      .make();
}
