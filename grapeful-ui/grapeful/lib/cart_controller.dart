// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:grapeful/product.dart';

class CartController extends GetxController {
  var _products = {}.obs;

  void addProduct(List<Datum> product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
    // print("Product ${product[0].title} added to the cart");
    // print(_products);

    print(_products.entries
        .map((product) => product.key[0].price * product.value));

    Get.snackbar(
        "Product Added", "You have added ${product[0].title} to the cart",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }

  void removeProduct(List<Datum> product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  get products => _products;

  get productSubTotal =>
      _products.entries.map((product) => product.key[0].price * product.value);

  get total => _products.entries
      .map((product) => product.key[0].price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}
