import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/consts/list.dart';
import 'package:meat_deliviry_app/controler/product_controller.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';

import 'package:meat_deliviry_app/screens/category_screen/category_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.white.fontFamily(bold).make(),
          automaticallyImplyLeading: false,
        ),
        body: GridView.builder(
          itemCount: categoriesList.length,
          padding: const EdgeInsets.all(5),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisExtent: 180,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  categoriesImages.elementAt(index),
                  height: 120,
                  width: 200,
                  fit: BoxFit.fitWidth,
                ).box.padding(const EdgeInsets.all(5)).make(),
                const Spacer(),
                categoriesList
                    .elementAt(index)
                    .text
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .make(),
                20.heightBox,
              ],
            ).box.white.roundedSM.shadowSm.clip(Clip.antiAlias).make().onTap(
              () {
                Get.to(
                  () => CategoryDetails(title: categoriesList.elementAt(index)),
                );
              },
            );
          },
        ).paddingOnly(top: 10),
      ),
    );
  }
}
