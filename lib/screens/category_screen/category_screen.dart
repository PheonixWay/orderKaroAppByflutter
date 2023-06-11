import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/consts/list.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';
import 'package:meat_deliviry_app/screens/category_screen/category_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: categoriesList.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisExtent: 200,
                mainAxisSpacing: 8),
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
              )
                  .box
                  .white
                  .roundedSM
                  .outerShadowSm
                  .clip(Clip.antiAlias)
                  .make()
                  .onTap(
                () {
                  Get.to(
                    () =>
                        CategoryDetails(title: categoriesList.elementAt(index)),
                  );
                },
              );
            },
          ).paddingOnly(top: 10),
        ),
      ),
    );
  }
}
