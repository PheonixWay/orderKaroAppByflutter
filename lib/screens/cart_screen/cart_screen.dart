import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      child: cartisEmpty.text
          .fontFamily(semibold)
          .color(darkFontGrey)
          .makeCentered(),
    );
  }
}
