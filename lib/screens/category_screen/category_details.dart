import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/controler/product_controller.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ));
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No Products Found!".text.color(darkFontGrey).make(),
              );
            } else {
              //geting data from snapshot in local variable
              var data = snapshot.data!.docs;

              //find this issue
              // controller.initailizingListElement(length: data.length);

              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.heightBox,
                    Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            mainAxisExtent: 340,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    data[index]["p_image"],
                                    width: 200,
                                    height: 130,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                10.heightBox,
                                "${data[index]["p_name"]}"
                                    .text
                                    .size(18)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                "500 g | ${data[index]["p_quantity"]}kg Available"
                                    .text
                                    .size(10)
                                    .fontFamily(regular)
                                    .color(fontGrey)
                                    .make(),
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
                                        .color(const Color.fromARGB(
                                            255, 33, 197, 93))
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
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .make(),
                                    IconButton(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5),
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              index,
                                              int.parse(
                                                  data[index]["p_quantity"]));
                                          controller.calculateTotallPrice(
                                              index,
                                              int.parse(
                                                  data[index]["p_price"]));
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          size: 15,
                                        )),
                                    Obx(
                                      () => "${controller.quantity[index]}"
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                    ),
                                    IconButton(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          controller.decreaseQuantity(index);
                                          controller.calculateTotallPrice(
                                              index,
                                              int.parse(
                                                  data[index]["p_price"]));
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
                                            if (controller.totalPrice[index] <=
                                                0) {
                                              VxToast.show(context,
                                                  msg:
                                                      "Please select quantity");
                                            } else {
                                              controller.addtoCart(
                                                context: context,
                                                title: data[index]["p_name"],
                                                img: data[index]["p_image"],
                                                qty: controller.quantity[index],
                                                tprice: controller
                                                    .totalPrice[index],
                                              );
                                              VxToast.show(context,
                                                  msg: "Added to cart");
                                              controller.resetValues(index);
                                            }
                                          },
                                          color: Colors.red,
                                          textcolor: whiteColor,
                                          data: "Cart"),
                                    ],
                                  ),
                                )
                              ],
                            )
                                .box
                                .white
                                .roundedSM
                                .outerShadowMd
                                .margin(const EdgeInsets.all(4))
                                .padding(const EdgeInsets.only(
                                    top: 5, left: 5, right: 5))
                                .make();
                          }),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
