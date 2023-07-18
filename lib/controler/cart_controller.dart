import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/controler/home_controller.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class CartController extends GetxController {
  var tprice = 0.obs;
  var paymentIndex = 1.obs;
  var selectedAddress = 0.obs;
  var adresscontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var statecontroller = TextEditingController();
  var codecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  //isme data save hoga
  Map<String, String> selectedAdrressData = {};

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

//totall price calculate kar rahe hai
  calculateTotalPrice(data) {
    tprice.value = 0;
    for (var i = 0; i < data.length; i++) {
      tprice = tprice + int.parse(data[i]["tprice"].toString());
    }
  }

  late dynamic productSnapshot;
  var productlist = [];
  var placingOrder = false.obs;

//pura data bhej rahe hai databse ko
  placeMyorder(ordermethod, totallamount) async {
    await FirestoreServices.getUserName();
    placingOrder(true);
    getProductDetails();
    await firestore.collection(orderCollection).doc().set({
      "order_code": "2584698754",
      "order_date": FieldValue.serverTimestamp(),
      "order_by": FirestoreServices.getUserUid(),
      "order_by_name": Get.find<HomeController>().userName,
      "order_by_email": FirestoreServices.getUserEmail(),
      "order_by_address": selectedAdrressData["address"],
      "order_by_state": selectedAdrressData["state"],
      "order_by_city": selectedAdrressData["city"],
      "order_by_code": selectedAdrressData["code"],
      "order_by_phone": selectedAdrressData["phone"],
      "shipping_method": "Home delivery",
      "payment_method": ordermethod,
      "order_placed": true,
      "order_confirmed": false,
      "order_delivered": false,
      "order_on_delivery": false,
      "totall_amount": totallamount,
      "orders": FieldValue.arrayUnion(productlist),
    });
    placingOrder(false);
  }

//product ka detail lerahe hai isse
  getProductDetails() {
    productlist.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      productlist.add({
        "image": productSnapshot[i]["img"],
        "qty": productSnapshot[i]["qty"],
        "title": productSnapshot[i]["title"],
        "price": productSnapshot[i]["tprice"],
      });
    }
  }

//after succesfull placing order isko use karenge
  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }

//iss function me data save kar rahe hai

  addressData(data) {
    selectedAdrressData.clear();
    selectedAdrressData["address"] = data["Address"];
    selectedAdrressData["city"] = data["city"];
    selectedAdrressData["state"] = data["state"];
    selectedAdrressData["phone"] = data["phone"];
    selectedAdrressData["code"] = data["code"];
  }

//agar koi address save nahi hoga to isko use karenge
  addAddress() async {
    await firestore.collection(addressCollection).doc().set({
      "userId": FirestoreServices.getUserUid(),
      "Address": adresscontroller.text,
      "city": citycontroller.text,
      "state": statecontroller.text,
      "code": codecontroller.text,
      "phone": phonecontroller.text,
    });
  }

  double getScreenWidth(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }
}
