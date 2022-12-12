// ignore_for_file: use_build_context_synchronously

import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/provider/orders_provider.dart';
import 'package:comedor_utt/src/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/order.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';

class ClientOrdersCreateController {

  BuildContext context;
  Function refresh;

  Product product;
  User user;

  int counter = 1;
  double productPrice;

  SharedPref sharedPref = SharedPref();

  List<Product> selectedProducts = [];
  double total = 0;
  
  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();

  List<String> tokens = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    selectedProducts = Product.fromJsonList(await sharedPref.read('order')).toList;
    user = User.fromJson(await sharedPref.read('user'));

    // if (!context.mounted) return;
    usersProvider.init(context, sessionUser: user);
    ordersProvider.init(context, user);

    getTotal();

    tokens = await usersProvider.getAdminsNotificationTokens();
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


  void createOrder() async {
    Order order = Order(
      idClient: user.id,
      products: selectedProducts
    );
    ResponseApi responseApi = await ordersProvider.create(order);
    print('Respuesta orden: ${responseApi.message}');
    
    selectedProducts.length = 0;
    sharedPref.save('order', selectedProducts);
    
    // if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
  }
}
