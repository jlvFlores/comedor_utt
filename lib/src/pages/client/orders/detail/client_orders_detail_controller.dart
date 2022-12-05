import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/order.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/provider/orders_provider.dart';
import 'package:comedor_utt/src/provider/users_provider.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';

class ClientOrdersDetailController {

  BuildContext context;
  Function refresh;

  Product product;

  int counter = 1;
  double productPrice;

  SharedPref sharedPref = SharedPref();

  double total = 0;
  Order order;

  User user;
  List<User> users = [];
  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  String idDelivery;

  Future init(BuildContext context, Function refresh, Order order) async {
    this.context = context;
    this.refresh = refresh;
    this.order = order;
    
    user = User.fromJson(await sharedPref.read('user'));
    
    if (!context.mounted) return;
    usersProvider.init(context, sessionUser: user);
    ordersProvider.init(context, user);
    
    getTotal();
    refresh();
  }

  void getTotal() {
    total = 0;
    for (var product in order.products) {
      total = total + (product.price * product.quantity);
    }
    refresh();
  }

}