import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/screens/auth_screen/login_screen.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/design_widget/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
// creating a method to change screen from splash screen to login and signup
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // using getx
      Get.to(() => const MyLogin());
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
            50.heightBox,
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                )),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            20.heightBox,
            // our splah screen ui is completed
          ],
        ),
      ),
    );
  }
}
