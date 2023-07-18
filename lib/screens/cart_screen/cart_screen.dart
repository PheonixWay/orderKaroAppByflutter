import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/controler/cart_controller.dart';

import 'package:meat_deliviry_app/design_widget/button_design.dart';
import 'package:meat_deliviry_app/screens/cart_screen/address_screen.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: lightGrey,
      bottomNavigationBar: ourButton(
          onPress: () {
            if (controller.productSnapshot == 0) {
              VxToast.show(context, msg: "Please Add item");
            } else {
              Get.to(() => const AddressScreen());
            }
          },
          data: "Place Order",
          textcolor: whiteColor,
          color: Colors.green),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Cart".text.color(redColor).fontFamily(bold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getCart(FirestoreServices.getUserUid()),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: redColor,
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              controller.productSnapshot = 0;
              return Center(
                child: cartisEmpty.text
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .make(),
              );
            } else {
              var data = snapshot.data!.docs;
              //adding cart data to this variable for fruther use
              controller.productSnapshot = data;
              controller.calculateTotalPrice(data);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 42,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(data[index]["img"]),
                                      radius: 40,
                                    ),
                                  ),
                                  10.heightBox,
                                  Row(
                                    children: [
                                      "Qty: "
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(semibold)
                                          .make(),
                                      "${data[index]["qty"]}"
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                    ],
                                  ),
                                ],
                              ).paddingAll(12),
                              30.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data[index]["title"]}"
                                      .text
                                      .size(18)
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  5.heightBox,
                                  "500 g"
                                      .text
                                      .fontFamily(regular)
                                      .color(fontGrey)
                                      .make(),
                                  5.heightBox,
                                  "Price:(Qty ${data[index]["qty"]})"
                                      .text
                                      .color(darkFontGrey)
                                      .fontFamily(semibold)
                                      .size(15)
                                      .make(),
                                  "${data[index]["tprice"]}"
                                      .numCurrency
                                      .text
                                      .color(Vx.green500)
                                      .fontFamily(semibold)
                                      .size(16)
                                      .make(),
                                  5.heightBox,
                                  ourButton(
                                      onPress: () {
                                        FirestoreServices.deletCartProduct(
                                            data[index].id);
                                        VxToast.show(context,
                                            msg: "Removed from  cart");
                                      },
                                      color: Colors.red,
                                      textcolor: whiteColor,
                                      data: "Remove"),
                                ],
                              ).paddingAll(10),
                            ],
                          )
                              .box
                              .color(whiteColor)
                              .shadowSm
                              .roundedSM
                              .margin(const EdgeInsets.all(5))
                              .make(),
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price"
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.green,
                                fontFamily: bold,
                                fontSize: 15),
                            children: <TextSpan>[
                              const TextSpan(text: "₹ "),
                              TextSpan(
                                  text:
                                      "${controller.tprice.value}".numCurrency)
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                      .box
                      .white
                      .roundedSM
                      .width(context.screenWidth - 10)
                      .padding(const EdgeInsets.all(12))
                      .color(golden)
                      .make(),
                ],
              );
            }
          }),
    );
  }
}
