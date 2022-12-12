// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/provider/categories_provider.dart';
import 'package:comedor_utt/src/provider/products_provider.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';

class DinerProductsListController {
  
  BuildContext context;
  SharedPref sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();
  List<Product> products = [];

  StreamController<String> streamController = StreamController();
  TextEditingController searchController = TextEditingController();

  Timer searchOnStoppedTyping;

  String productName = '';
  bool isUpdated;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));

    // if (!context.mounted) return;
    categoriesProvider.init(context, user);
    productsProvider.init(context, user);

    refresh();
  }

  void onChangeText(String text) {
    const duration = Duration(milliseconds:800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping.cancel();
      refresh();
    }

    searchOnStoppedTyping = Timer(duration, () {
      productName = text;
      refresh();
      // getProducts(idCategory, text)
      print('TEXTO COMPLETO $text');
    });
  }

  Future<List<Product>> getProducts(String productName) async {
    if (productName.isEmpty) {
      return await productsProvider.getAll();
    }
    else {
      return await productsProvider.getByProductName(productName);
    }
  }

  void showAlertDialog(Product product) {
    Widget deleteButton = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          productsProvider.delete(product.id);
          refresh();
        },
        child: const Text('BORRAR'));

    Widget cancelButton = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('CANCELAR'));

    AlertDialog alertDialog = AlertDialog(
      title: const Text('¿Seguro que desea borrar este producto?!'),
      actions: [deleteButton, cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      }
    );
  }

  void logout() {
    sharedPref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }

  void goToOrdersList() {
    Navigator.pushNamed(context, 'client/orders/list');
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToContactPage() {
    Navigator.pushNamed(context, 'client/contact');
  }
}
