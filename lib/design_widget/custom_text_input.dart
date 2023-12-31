import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget customTextField(
    {String? title, String? hint, controller, ispass, isEnable}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.fontFamily(semibold).color(redColor).size(16).make(),
      5.heightBox,
      TextFormField(
        enabled: isEnable,
        obscureText: ispass,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "*Required";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: hint,
            isDense: true,
            fillColor: whiteColor,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      ),
      5.heightBox,
    ],
  );
}
