import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductsDetailController {

  BuildContext context;
  Function refresh;

  Product product;

  int counter = 1;
  double productPrice;

  SharedPref sharedPref = SharedPref();

  List<Product> selectedProducts = [];

  Future init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    productPrice = product.price;

    // sharedPref.remove('order');
    selectedProducts = Product.fromJsonList(await sharedPref.read('order')).toList;

    for (var p in selectedProducts) {
      print('Producto seleccionado: ${p.toJson()}');
    }

    refresh();
  }

  void addToBag() {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);

    if (index == -1) { // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      product.quantity ??= 1;

      selectedProducts.add(product);
    }
    else {
      selectedProducts[index].quantity = counter;
    }

    sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Producto agregado');
  }

  void addItem() {
    counter = counter + 1;
    productPrice = product.price * counter;
    product.quantity = counter;
    refresh();
  }

  void removeItem() {
    if (counter > 1) {
      counter = counter - 1;
      productPrice = product.price * counter;
      product.quantity = counter;
      refresh();
    }
  }

  void close() {
    Navigator.pop(context);
  }

}