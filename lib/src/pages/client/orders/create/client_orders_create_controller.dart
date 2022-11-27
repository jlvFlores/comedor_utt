import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientOrdersCreateController {

  BuildContext context;
  Function refresh;

  Product product;

  int counter = 1;
  double productPrice;

  SharedPref sharedPref = SharedPref();

  List<Product> selectedProducts = [];
  double total = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    selectedProducts = Product.fromJsonList(await sharedPref.read('order')).toList;

    getTotal();

    refresh();
  }

  void getTotal() {
    total = 0;
    for (var product in selectedProducts) {
      total = total + (product.quantity * product.price);
    }
    refresh();
  }

  void addItem(Product product) {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts[index].quantity = selectedProducts[index].quantity + 1;
    sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void removeItem(Product product) {
    if (product.quantity > 1) {
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      selectedProducts[index].quantity = selectedProducts[index].quantity - 1;
      sharedPref.save('order', selectedProducts);
      getTotal();
    }
  }

  void deleteItem(Product product) {
    selectedProducts.removeWhere((p) => p.id == product.id);
    sharedPref.save('order', selectedProducts);
    getTotal();
  }
}