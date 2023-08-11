import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/consts/list.dart';
import 'package:meat_deliviry_app/controler/product_controller.dart';
import 'package:meat_deliviry_app/design_widget/all_product_home_screen.dart';
import 'package:meat_deliviry_app/design_widget/home_buttons.dart';
import 'package:meat_deliviry_app/screens/category_screen/category_details.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Container(
      color: lightGrey,
      width: context.screenHeight,
      height: context.screenHeight,
      padding: const EdgeInsets.all(8),
      child: SafeArea(
        child: SingleChildScrollView(
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
              Column(
                children: [
                  5.heightBox,
                  //shop images will be here
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
                        child: categories.text
                            .fontFamily(semibold)
                            .size(18)
                            .color(darkFontGrey)
                            .make()),
                  ),
                  10.heightBox,
                  //3 categories are here boiler poultry and parent
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: context.screenWidth * 0.9,
                          height: context.screenHeight * 0.13,
                          child: Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return homeButton(
                                  height: context.screenHeight * 0.13,
                                  width: context.screenWidth / 3.5,
                                  icon:
                                      homeScreenCategoryIcon1.elementAt(index),
                                  titles:
                                      homeScreenCategorylist1.elementAt(index),
                                ).paddingOnly(right: 10).onTap(() {
                                  Get.to(
                                    () => CategoryDetails(
                                        title: homeScreenCategorylist1
                                            .elementAt(index)),
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                      ]),
                  10.heightBox,
                  //3 categories are here second desi and egg
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: context.screenWidth * 0.9,
                          height: context.screenHeight * 0.13,
                          child: Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return homeButton(
                                  height: context.screenHeight * 0.13,
                                  width: context.screenWidth / 3.5,
                                  icon:
                                      homeScreenCategoryIcon2.elementAt(index),
                                  titles:
                                      homeScreenCategorylist2.elementAt(index),
                                ).paddingOnly(right: 10).onTap(() {
                                  Future.delayed(const Duration(seconds: 1));
                                  Get.to(
                                    () => CategoryDetails(
                                        title: homeScreenCategorylist2
                                            .elementAt(index)),
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                      ]),

                  //Featured product
                  //i will implement it after some time

                  // StreamBuilder(
                  //   stream: FirestoreServices.getTopChicken(),
                  //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //     if (!snapshot.hasData) {
                  //       return const Center(
                  //         child: CircularProgressIndicator(
                  //           valueColor: AlwaysStoppedAnimation(redColor),
                  //         ),
                  //       );
                  //     } else {
                  //       var data = snapshot.data!.docs;
                  //       controller1.initailizingListElement(
                  //           length: data.length);

                  //       return topProduct(
                  //           data: data,
                  //           controller1: controller1,
                  //           controller: controller);
                  //     }
                  //   },
                  // ),

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
                          return allProductHomeScreen(
                              data: data, controller: controller);
                        }
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
