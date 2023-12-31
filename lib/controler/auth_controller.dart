import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var isloading = false.obs;

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //stroing data method

  storeUserData({name, email, password}) async {
    var auth1 = FirebaseAuth.instance;
    var uid = auth1.currentUser!.uid;
    DocumentReference store = firestore.collection(userCollection).doc(uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      "id": currentuser!.uid.toString(),
      "cart_count": "00",
      "wislist_count": "00",
      "order_count": "00"
    });
  }

  //signout method
  signoutMethod({context}) async {
    try {
      var user = FirebaseAuth.instance;
      user.signOut();
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
