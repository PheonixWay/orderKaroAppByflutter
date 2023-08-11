import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';

Widget allProductHomeScreen({data, controller}) {
  return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 340),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              data[index]["p_image"],
              width: 200,
              height: 130,
              fit: BoxFit.fill,
            ),
            10.heightBox,
            "${data[index]["p_name"]}"
                .text
                .size(16)
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make(),
            "500 g | ${data[index]["p_quantity"]}kg Available"
                .text
                .size(8)
                .color(fontGrey)
                .make(),
            10.heightBox,
            Row(
              children: [
                "₹ ".text.color(Vx.green500).fontFamily(bold).size(16).make(),
                "${data[index]["p_price"]}/"
                    .text
                    .color(const Color.fromARGB(255, 33, 197, 93))
                    .fontFamily(bold)
                    .size(16)
                    .make(),
                "${data[index]["weight"]}"
                    .text
                    .color(Vx.green500)
                    .fontFamily(regular)
                    .size(10)
                    .make(),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                "Qty:"
                    .text
                    .size(12)
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .make(),
                IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      controller.increaseQuantity(
                          index, int.parse(data[index]["p_quantity"]));
                      controller.calculateTotallPrice(
                          index, int.parse(data[index]["p_price"]));
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 15,
                    )),
                Obx(
                  () => "${controller.quantity[index]}"
                      .text
                      .size(10)
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .make(),
                ),
                IconButton(
                    padding: const EdgeInsets.only(right: 5),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      controller.decreaseQuantity(index);
                      controller.calculateTotallPrice(
                          index, int.parse(data[index]["p_price"]));
                    },
                    icon: const Icon(
                      Icons.remove,
                      size: 15,
                    )),
              ],
            ),
            Expanded(
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: const EdgeInsets.all(0),
                children: [
                  ourButton(
                      onPress: () {},
                      color: Colors.green,
                      textcolor: whiteColor,
                      data: "Buy"),
                  ourButton(
                      onPress: () {
                        if (controller.totalPrice[index] <= 0) {
                          VxToast.show(context, msg: "Please select quantity");
                        } else {
                          controller.addtoCart(
                            context: context,
                            title: data[index]["p_name"],
                            img: data[index]["p_image"],
                            qty: controller.quantity[index],
                            tprice: controller.totalPrice[index],
                          );
                          VxToast.show(context, msg: "Added to cart");
                          controller.resetValues(index);
                        }
                      },
                      color: Colors.red,
                      textcolor: whiteColor,
                      data: "Cart"),
                ],
              ),
            ),
          ],
        )
            .box
            .white
            .roundedSM
            .margin(const EdgeInsets.all(4))
            .padding(const EdgeInsets.all(8))
            .make();
      });
}
