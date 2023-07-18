import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/firebase_const.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class AddressDetailsController extends GetxController {
  var adresscontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var statecontroller = TextEditingController();
  var codecontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  double getScreenWidth(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  addAddress() async {
    await firestore.collection(addressCollection).doc().set({
      "userId": FirestoreServices.getUserUid(),
      "Address": adresscontroller.text,
      "city": citycontroller.text,
      "state": statecontroller.text,
      "code": codecontroller.text,
      "phone": phonecontroller.text,
    });
    adresscontroller.clear();
    citycontroller.clear();
    statecontroller.clear();
    codecontroller.clear();
    phonecontroller.clear();
  }
}
