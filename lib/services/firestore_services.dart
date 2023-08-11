import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/firebase_const.dart';
import 'package:meat_deliviry_app/controler/home_controller.dart';

class FirestoreServices {
  //get user data from firestore
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where("id", isEqualTo: uid)
        .snapshots();
  }

  //get product according to category
  static getProducts(category) {
    return firestore
        .collection(productCollection)
        .where("p_category", isEqualTo: category)
        .snapshots();
  }

  //get product according to category
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where("addedby", isEqualTo: uid)
        .snapshots();
  }

  static getUserUid() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
  }

  static getUserName() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    await firestore
        .collection(userCollection)
        .where("id", isEqualTo: user!.uid)
        .get()
        .then((value) {
      var data = value.docs[0].data();
      Get.find<HomeController>().userName = data["name"];
    });

    return;
  }

  static getUserEmail() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user!.email;
    return email;
  }

  static deletCartProduct(id) {
    return firestore.collection(cartCollection).doc(id).delete();
  }

  static getOrders(uid) {
    return firestore
        .collection(orderCollection)
        .where("order_by", isEqualTo: uid)
        .snapshots();
  }

  static getAddress(uid) {
    return firestore
        .collection(addressCollection)
        .where("userId", isEqualTo: uid)
        .snapshots();
  }

  static deleteAddress(id) {
    return firestore.collection(addressCollection).doc(id).delete();
  }

  static getCount(uid) async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where("addedby", isEqualTo: uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderCollection)
          .where("order_by", isEqualTo: uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
      //this is for whislist fetching count
      // firestore
      //     .collection(cartCollection)
      //     .where("order_by", isEqualTo: uid)
      //     .get()
      //     .then((value) {
      //   return value.docs.length;
      // }),
    ]);
    return res;
  }

  static getAllProducts() {
    return firestore.collection(productCollection).snapshots();
  }

  static getTopChicken() {
    return firestore
        .collection(productCollection)
        .where("p_category2", isEqualTo: "TopChicken")
        .snapshots();
  }
}
