import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/controler/profile_controller.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';
import 'package:meat_deliviry_app/design_widget/custom_text_input.dart';

import '../../consts/consts.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    controller.nameController.text = data['name'];
    controller.passController.text = data['password'];

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: editprofile.text.fontFamily(semibold).make(),
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.profileImagepath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : Image.file(
                    File(controller.profileImagepath.value),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
            5.heightBox,
            ourButton(
                onPress: () {
                  controller.changeImage(context);
                },
                color: redColor,
                textcolor: whiteColor,
                data: change),
            20.heightBox,
            customTextField(
                title: name,
                hint: nameHint,
                ispass: false,
                controller: controller.nameController),
            customTextField(
                title: password,
                hint: passwordHint,
                ispass: true,
                controller: controller.passController),
            15.heightBox,
            ourButton(
                    data: save,
                    color: redColor,
                    textcolor: whiteColor,
                    onPress: () {})
                .box
                .width(context.screenWidth - 40)
                .make(),
          ],
        )
            .box
            .white
            .shadowSm
            .rounded
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .padding(const EdgeInsets.all(16))
            .make(),
      ),
    ));
  }
}
