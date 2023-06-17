import 'package:flutter/material.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';
import 'package:meat_deliviry_app/design_widget/custom_text_input.dart';

import '../../consts/consts.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: editprofile.text.fontFamily(semibold).make(),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imgProfile2,
            width: 100,
            fit: BoxFit.cover,
          ).box.roundedFull.clip(Clip.antiAlias).make(),
          5.heightBox,
          ourButton(
              onPress: () {},
              color: redColor,
              textcolor: whiteColor,
              data: change),
          20.heightBox,
          customTextField(title: name, hint: nameHint, ispass: false),
          customTextField(title: password, hint: passwordHint, ispass: true),
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
    ));
  }
}
