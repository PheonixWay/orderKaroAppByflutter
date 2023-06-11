import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/design_widget/app_logo.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';
import 'package:meat_deliviry_app/design_widget/custom_text_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              15.heightBox,
              "Join the $appname".text.white.fontFamily(bold).size(19).make(),
              20.heightBox,
              SingleChildScrollView(
                child: Column(children: [
                  customTextField(title: name, hint: nameHint),
                  customTextField(title: emial, hint: emailHint),
                  customTextField(title: password, hint: passwordHint),
                  customTextField(title: retypePass, hint: passwordHint),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: isChecked,
                          onChanged: (newValue) {
                            setState(() {
                              isChecked = newValue;
                            });
                          }),
                      5.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: termandCondi,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                        ])),
                      )
                    ],
                  ),
                  ourButton(
                          textcolor: isChecked == true ? whiteColor : fontGrey,
                          onPress: () {},
                          color: isChecked == true ? redColor : lightgolden,
                          data: signup)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  //usng velocity x i am applying gesture detector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyhaveAccount.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      }),
                    ],
                  ),
                  5.heightBox,
                ])
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
