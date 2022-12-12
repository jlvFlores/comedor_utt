// ignore_for_file: use_build_context_synchronously

import 'package:comedor_utt/src/models/order.dart';
import 'package:comedor_utt/src/pages/diner/orders/detail/diner_orders_detail_page.dart';
import 'package:comedor_utt/src/provider/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DinerOrdersListController {
  BuildContext context;
  SharedPref sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function refresh;
  User user;

  List<String> status = ['PENDIENTE', 'ENTREGADO'];
  OrdersProvider ordersProvider = OrdersProvider();

  bool isUpdated;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));

    // if (!context.mounted) return null;
    ordersProvider.init(context, user);

    refresh();
  }

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.getByStatus(status);
  }

  Future<void> openBottomSheet(Order order) async {
    isUpdated = await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => DinerOrdersDetailPage(order: order)
    );

    if (isUpdated != null && isUpdated) {
      refresh();
    }
  }

  void logout() {
    sharedPref.logout(context, user.id);
  }

  void goToCategoryCreate() {
    Navigator.pushNamed(context, 'diner/categories/create');
  }

  void goToProductCreate() {
    Navigator.pushNamed(context, 'diner/products/create');
  }

  void goToProductList() {
    Navigator.pushNamed(context, 'diner/products/list');
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}
