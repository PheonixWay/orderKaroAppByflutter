import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/consts/list.dart';
import 'package:meat_deliviry_app/controler/product_controller.dart';
import 'package:meat_deliviry_app/design_widget/featured_button.dart';
import 'package:meat_deliviry_app/design_widget/home_buttons.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';
import '../../design_widget/button_design.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Container(
      color: lightGrey,
      width: context.screenHeight,
      height: context.screenHeight,
      padding: const EdgeInsets.all(8),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    suffixIcon: Icon(Icons.search),
                    fillColor: whiteColor,
                    hintText: searchanything,
                    hintStyle: TextStyle(color: textfieldGrey)),
              ),
            ),
            5.heightBox,
            //first swiper
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList.elementAt(index),
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    20.heightBox,
                    //two buttons top choice and top
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButton(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            titles: index == 0 ? topChoice : budgetMeat),
                      ),
                    ),
                    //second slider
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList2.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList2.elementAt(index),
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButton(
                          height: context.screenHeight * 0.13,
                          width: context.screenWidth / 3.5,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          titles: index == 0
                              ? topcategory
                              : index == 1
                                  ? brands
                                  : topseller,
                        ),
                      ),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButton(
                          height: context.screenHeight * 0.13,
                          width: context.screenWidth / 3.5,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          titles: index == 0
                              ? topcategory
                              : index == 1
                                  ? brands
                                  : topseller,
                        ),
                      ),
                    ),

                    20.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: featuredcat.text
                              .fontFamily(semibold)
                              .size(18)
                              .color(darkFontGrey)
                              .make()),
                    ),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              featuredButton(
                                  icon: featuredImg1.elementAt(index),
                                  titles: featuredTitles1.elementAt(index)),
                              10.heightBox,
                              featuredButton(
                                  icon: featuredImg2.elementAt(index),
                                  titles: featuredTitles2.elementAt(index)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Featured product
                    20.heightBox,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          5.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                6,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 4GB/64GB"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    "\$600"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                    20.heightBox,
                                  ],
                                )
                                    .box
                                    .white
                                    .roundedSM
                                    .margin(
                                      const EdgeInsets.only(left: 2, right: 8),
                                    )
                                    .padding(const EdgeInsets.all(8))
                                    .make(),
                              ),
                            ),
                          ),
                          6.heightBox,
                        ],
                      ),
                    ),
                    //third swiper
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList.elementAt(index),
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    20.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: allProduct.text
                              .fontFamily(semibold)
                              .size(18)
                              .color(darkFontGrey)
                              .make()),
                    ),
                    10.heightBox,
                    //all ptroduct section
                    StreamBuilder(
                        stream: FirestoreServices.getAllProducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              ),
                            );
                          } else {
                            var data = snapshot.data!.docs;
                            controller.initailizingListElement(
                                length: data.length);
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2,
                                        mainAxisExtent: 300),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          "Qty:"
                                              .text
                                              .color(darkFontGrey)
                                              .fontFamily(semibold)
                                              .make(),
                                          IconButton(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 5),
                                              constraints:
                                                  const BoxConstraints(),
                                              onPressed: () {
                                                controller.increaseQuantity(
                                                    index,
                                                    int.parse(data[index]
                                                        ["p_quantity"]));
                                                controller.calculateTotallPrice(
                                                    index,
                                                    int.parse(data[index]
                                                        ["p_price"]));
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 15,
                                              )),
                                          Obx(
                                            () =>
                                                "${controller.quantity[index]}"
                                                    .text
                                                    .color(darkFontGrey)
                                                    .fontFamily(bold)
                                                    .make(),
                                          ),
                                          IconButton(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              constraints:
                                                  const BoxConstraints(),
                                              onPressed: () {
                                                controller
                                                    .decreaseQuantity(index);
                                                controller.calculateTotallPrice(
                                                    index,
                                                    int.parse(data[index]
                                                        ["p_price"]));
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 15,
                                              )),
                                        ],
                                      ),
                                      10.heightBox,
                                      Expanded(
                                        child: ButtonBar(
                                          alignment:
                                              MainAxisAlignment.spaceBetween,
                                          buttonPadding:
                                              const EdgeInsets.all(0),
                                          children: [
                                            ourButton(
                                                onPress: () {},
                                                color: Colors.green,
                                                textcolor: whiteColor,
                                                data: "Buy"),
                                            ourButton(
                                                onPress: () {
                                                  if (controller
                                                          .totalPrice[index] <=
                                                      0) {
                                                    VxToast.show(context,
                                                        msg:
                                                            "Please select quantity");
                                                  } else {
                                                    controller.addtoCart(
                                                      context: context,
                                                      title: data[index]
                                                          ["p_name"],
                                                      img: data[index]
                                                          ["p_image"],
                                                      qty: controller
                                                          .quantity[index],
                                                      tprice: controller
                                                          .totalPrice[index],
                                                    );
                                                    VxToast.show(context,
                                                        msg: "Added to cart");
                                                    controller
                                                        .resetValues(index);
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
                                      .padding(const EdgeInsets.all(12))
                                      .make();
                                });
                          }
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
