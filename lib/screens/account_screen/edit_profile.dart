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
            //if both are empty so show default image
            controller.profileImagepath.isEmpty && data['imageUrl'] == ''
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : //if only selected image is empty but have network image then show network image
                data['imageUrl'] != '' && controller.profileImagepath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : //if selected image is not empty then this
                    Image.file(
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

            15.heightBox,
            controller.isloading.value == true
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : ourButton(
                    data: save,
                    color: redColor,
                    textcolor: whiteColor,
                    onPress: () async {
                      if (controller.nameController.text.isEmpty) {
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Please Enter Name");
                        //
                      } else if (controller.profileImagepath.value.isNotEmpty) {
                        controller.isloading.value = true;
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = data['imageUrl'];
                      }
                      if (controller.profileImageLink.isNotEmpty) {
                        await controller.updateProfile(
                            name: controller.nameController.text,
                            imageUrl: controller.profileImageLink);
                        controller.isloading.value = false;
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Updated");
                      }
                      // controller.isloading(true);
                    }).box.width(context.screenWidth - 40).make(),
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
