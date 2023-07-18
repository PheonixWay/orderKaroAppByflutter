import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';

import 'package:meat_deliviry_app/controler/categoryModel.dart';

class ProductController extends GetxController {
  var subCat = [];

  //created array to store diffrent values to specif index also initalize with length of data so it will not crash
  var quantity = List.filled(1, 0).obs;
  var increasequantitiy = []; //this is initial value to quantity
  var totalPrice = List.filled(1, 0).obs; //this is initial value to quantity

  getSubCategories({title}) async {
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subCategory) {
      subCat.add(e);
    }
  }

  increaseQuantity(index, totalquantity) {
    if (quantity[index].isLowerThan(totalquantity * 2)) {
      quantity[index] =
          ++increasequantitiy[index]; //adding data to array to specif index
    }
  }

  decreaseQuantity(index) {
    if (quantity[index] > 0) {
      quantity[index] =
          --increasequantitiy[index]; //deleting data to array to specif index
    }
  }

  calculateTotallPrice(index, price) {
    totalPrice[index] = price * increasequantitiy[index];
  }

//initalizing length of data repetadly so it will not created bunch of values only values according to data
  initailizingListElement({length}) {
    quantity.value = List.filled(length, 0);
    totalPrice.value = List.filled(length, 0);
    increasequantitiy = List.filled(length, 0);
  }

  addtoCart({title, tprice, sellername, qty, img, context}) async {
    await firestore
        .collection(cartCollection)
        .doc()
        .set(({
          "title": title,
          "img": img,
          "qty": qty,
          "tprice": tprice,
          // "VendorId": vendorID,
          "addedby": currentuser!.uid,
        }))
        .catchError((onerror) {
      VxToast.show(context, msg: onerror.toString());
    });
  }

  resetValues(index) {
    totalPrice[index] = 0;
    quantity[index] = 0;
  }
}
