import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget customTextField({String? title, String? hint, controller, ispass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.fontFamily(semibold).color(redColor).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: ispass,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      ),
      5.heightBox,
    ],
  );
}
