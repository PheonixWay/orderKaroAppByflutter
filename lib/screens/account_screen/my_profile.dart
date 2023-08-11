import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/controler/profile_controller.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';
import 'package:meat_deliviry_app/design_widget/custom_text_input.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    controller.setProfileData();
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: myProfile.text.fontFamily(semibold).make(),
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        //if both are empty so show default image
        Image.network(
          controller.profileData["imageUrl"],
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ).box.roundedFull.clip(Clip.antiAlias).make(),
        20.heightBox,
        customTextField(
            title: name,
            hint: nameHint,
            ispass: false,
            isEnable: false,
            controller: controller.nameForProfileC),
        customTextField(
          isEnable: false,
          title: emial,
          hint: emailHint,
          ispass: false,
          controller: controller.emailForProfileC,
        ),
      ])
          .box
          .white
          .shadowSm
          .rounded
          .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
          .padding(const EdgeInsets.all(16))
          .make(),
    ));
   
  }
}
