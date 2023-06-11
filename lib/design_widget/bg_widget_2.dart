import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget bgWidget2({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imgBackground2),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
