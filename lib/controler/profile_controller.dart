import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

class ProfileController extends GetxController {
  var isloading = false.obs;
  var profileImagepath = ''.obs;
  var profileImageLink = '';
  var nameController = TextEditingController();
  var passController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImagepath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImagepath.value);
    var destination = 'image/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref(destination);
    await ref.putFile(File(profileImagepath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imageUrl}) async {
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({'name': name, 'password': password, 'imageUrl': imageUrl},
        SetOptions(merge: true));
    isloading(false);
  }
}
