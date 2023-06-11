import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:meat_deliviry_app/screens/splashScreen/spalsh_screen.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //i am usng getx to change screen so here we have to use getmaterial app
    return GetMaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
