// ignore_for_file: use_build_context_synchronously

import 'package:comedor_utt/src/provider/push_notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/order.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/provider/orders_provider.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DinerOrdersDetailController {

  BuildContext context;
  Function refresh;

  Product product;

  int counter = 1;
  double productPrice;

  SharedPref sharedPref = SharedPref();

  double total = 0;
  Order order;

  User user;
  OrdersProvider ordersProvider = OrdersProvider();

  PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();

  Future init(BuildContext context, Function refresh, Order order) async {
    this.context = context;
    this.refresh = refresh;
    this.order = order;
    
    user = User.fromJson(await sharedPref.read('user'));
    
    // if (!context.mounted) return null;
    ordersProvider.init(context, user);

    getTotal();
    refresh();
  }

  void sendNotification(String tokenConfirm) {

    Map<String, dynamic> data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK'
    };

    pushNotificationsProvider.sendMessage(
        tokenConfirm,
        data,
        'PEDIDO REGISTRADO',
        'Tu pedido estará preparado en 15 minutos'
    );
  }

  void updateOrder() async {
    ResponseApi responseApi = await ordersProvider.updateToDelivered(order);

    sendNotification(user.notificationToken);

    Fluttertoast.showToast(msg: responseApi.message, toastLength: Toast.LENGTH_LONG);
    
    // if (!context.mounted) return;
    Navigator.pop(context, true); // Closes the details page
  }


  void getTotal() {
    total = 0;
    for (var product in order.products) {
      total = total + (product.price * product.quantity);
    }
    refresh();
  }

}