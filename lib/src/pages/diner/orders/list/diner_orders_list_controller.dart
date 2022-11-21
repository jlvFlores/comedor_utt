import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';

class DinerOrdersListController {
  BuildContext? context;
  SharedPref sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    refresh();
  }

  void logout() {
    sharedPref.logout(context!, user!.id!);
  }

  void goToCategoryCreate() {
    Navigator.pushNamed(context!, 'diner/categories/create');
  }

  void goToProductCreate() {
    Navigator.pushNamed(context!, 'diner/products/create');
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }
  
  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }
}
