import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

Widget orderStatus({title, colors, icons, showDone}) {
  return ListTile(
    minVerticalPadding: 20,
    leading: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Icon(
        icons,
        color: colors,
      ),
    ),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "$title".text.make(),
            showDone
                ? const Icon(
                    Icons.done_all_rounded,
                    color: redColor,
                  )
                : Container(),
          ],
        ),
      ),
    ),
  );
}

Widget orderPlaceDetails({String? name1, String? name2, data1, data2}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name1!.text.fontFamily(semibold).make(),
            2.heightBox,
            "$data1".text.make(),
          ],
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          name2!.text.fontFamily(semibold).make(),
          2.heightBox,
          "$data2".text.make(),
        ])
      ],
    ),
  );
}

Widget totalDetails({String? name1, data1}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name1!.text.fontFamily(semibold).make(),
          ],
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          "₹ $data1".text.color(Vx.green500).bold.make(),
        ])
      ],
    ),
  );
}
