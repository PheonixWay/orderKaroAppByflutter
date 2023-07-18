import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/consts/list.dart';
import 'package:meat_deliviry_app/controler/auth_controller.dart';
import 'package:meat_deliviry_app/design_widget/app_logo.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';
import 'package:meat_deliviry_app/design_widget/custom_text_input.dart';
import 'package:meat_deliviry_app/screens/auth_screen/signup_screen.dart';
import 'package:meat_deliviry_app/screens/home_screen/home.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerforLogin = Get.put(AuthController());

    //

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              15.heightBox,
              "Log in to $appname".text.white.fontFamily(bold).size(19).make(),
              20.heightBox,
              SingleChildScrollView(
                child: Column(children: [
                  customTextField(
                      title: emial,
                      hint: emailHint,
                      ispass: false,
                      controller: controllerforLogin.emailController),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      ispass: true,
                      controller: controllerforLogin.passController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgotPass.text.make())),
                  5.heightBox,
                  Obx(
                    () => controllerforLogin.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                                textcolor: whiteColor,
                                onPress: () async {
                                  controllerforLogin.isloading(true);
                                  await controllerforLogin
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      FirestoreServices.getUserName();
                                      Get.offAll(() => const Home());
                                    } else {
                                      controllerforLogin.isloading(false);
                                    }
                                  });
                                },
                                color: redColor,
                                data: login)
                            .box
                            .width(context.screenWidth - 50)
                            .make(),
                  ),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                          textcolor: redColor,
                          onPress: () {
                            Get.to(() => const SignUp());
                          },
                          color: lightgolden,
                          data: signup)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: lightGrey,
                                child: Image.asset(
                                  socialIconList.elementAt(index),
                                  width: 35,
                                ),
                              ),
                            ).onTap(() {})),
                  ),
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
