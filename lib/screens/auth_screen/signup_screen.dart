import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/controler/auth_controller.dart';
import 'package:meat_deliviry_app/design_widget/app_logo.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';
import 'package:meat_deliviry_app/design_widget/custom_text_input.dart';
import 'package:meat_deliviry_app/screens/home_screen/home.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var repassController = TextEditingController();

  //var for checkbox
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
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      ispass: false),
                  customTextField(
                      title: emial,
                      hint: emailHint,
                      controller: emailController,
                      ispass: false),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passController,
                      ispass: true),
                  customTextField(
                      title: retypePass,
                      hint: passwordHint,
                      controller: repassController,
                      ispass: true),
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
                  Obx(
                    () => controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                                textcolor:
                                    isChecked == true ? whiteColor : fontGrey,
                                onPress: () async {
                                  //checking condition wheter checkbox is cheked or not
                                  if (isChecked != false) {
                                    controller.isloading(true);
                                    try {
                                      //using method to create user
                                      await controller
                                          .signupMethod(
                                              context: context,
                                              email: emailController.text,
                                              password: repassController.text)
                                          .then((value) {
                                        //then after completing user creation then perform storeuser data to save user data
                                        return controller.storeUserData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: repassController.text);
                                      }).then((value) {
                                        VxToast.show(context, msg: loggedin);

                                        Get.offAll(const Home());
                                        FirestoreServices.getUserName();
                                      });
                                    } catch (e) {
                                      controller.isloading(false);
                                      controller.signoutMethod();
                                    }
                                  }
                                },
                                color:
                                    isChecked == true ? redColor : lightgolden,
                                data: signup)
                            .box
                            .width(context.screenWidth - 50)
                            .make(),
                  ),
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
