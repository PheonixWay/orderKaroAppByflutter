import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;

  var quantity = List.filled(100, 0).obs;
  var increasequantitiy = [0, 0, 0, 0]; //this is initial value to quantity
  var totalPrice = List.filled(100, 0).obs;

  increaseQuantity(index, totalquantity) {
    if (quantity[index].isLowerThan(totalquantity * 2)) {
      quantity[index] =
          ++increasequantitiy[index]; //adding data to array to specif index
    }
  }

  initailizingListElement({length}) {
    quantity.value = List.filled(length, 0);
    totalPrice.value = List.filled(length, 0);
    increasequantitiy = List.filled(length, 0);
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

  resetValues(index) {
    totalPrice[index] = 0;
    quantity[index] = 0;
  }

  var userName;
}
