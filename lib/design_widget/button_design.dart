import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget ourButton({onPress, color, textcolor, String? data}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    child: data!.text.fontFamily(bold).color(textcolor).make(),
  );
}
