import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(
          thickness: 0.5,
        ),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                onPress: () {
                  SystemNavigator.pop();
                },
                color: Colors.green,
                data: "Yes",
                textcolor: whiteColor),
            ourButton(
                onPress: () {
                  Navigator.pop(context);
                },
                color: Colors.red,
                data: "No",
                textcolor: whiteColor),
          ],
        )
      ],
    ).box.color(whiteColor).rounded.padding(const EdgeInsets.all(12)).make(),
  );
}
