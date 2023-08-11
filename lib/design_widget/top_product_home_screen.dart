import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';

Widget topProduct({data, controller1, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 5),
        child: topChiken.text.white.fontFamily(bold).size(18).make(),
      ),
      5.heightBox,
      SizedBox(
        width: double.infinity,
        height: 250,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    data[index]["p_image"],
                    width: 100,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                  5.heightBox,
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
                  5.heightBox,
                  Row(
                    children: [
                      "₹ "
                          .text
                          .color(Vx.green500)
                          .fontFamily(bold)
                          .size(16)
                          .make(),
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
                    children: [
                      "Qty:"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      IconButton(
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            controller1.increaseQuantity(
                                index, int.parse(data[index]["p_quantity"]));
                            controller1.calculateTotallPrice(
                                index, int.parse(data[index]["p_price"]));
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 15,
                          )),
                      Obx(
                        () => "${controller1.quantity[index]}"
                            .text
                            .size(10)
                            .color(darkFontGrey)
                            .fontFamily(bold)
                            .make(),
                      ),
                      IconButton(
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            controller1.decreaseQuantity(index);
                            controller1.calculateTotallPrice(
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
                              if (controller1.totalPrice[index] <= 0) {
                                VxToast.show(context,
                                    msg: "Please select quantity");
                              } else {
                                controller.addtoCart(
                                  context: context,
                                  title: data[index]["p_name"],
                                  img: data[index]["p_image"],
                                  qty: controller1.quantity[index],
                                  tprice: controller1.totalPrice[index],
                                );
                                VxToast.show(context, msg: "Added to cart");
                                controller1.resetValues(index);
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
                  .width(200)
                  .roundedSM
                  .margin(
                    const EdgeInsets.only(left: 10, right: 7),
                  )
                  .padding(const EdgeInsets.all(8))
                  .make();
            }),
      ),
      10.heightBox,
    ],
  ).color(redColor);
}
