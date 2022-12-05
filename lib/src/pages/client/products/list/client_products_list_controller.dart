// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/models/category.dart';
import 'package:comedor_utt/src/provider/categories_provider.dart';
import 'package:comedor_utt/src/provider/products_provider.dart';
import 'package:comedor_utt/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController {
  
  BuildContext context;
  SharedPref sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();
  List<Category> categories = [];

  StreamController<String> streamController = StreamController();
  TextEditingController searchController = TextEditingController();

  Timer searchOnStoppedTyping;

  String productName = '';

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));

    // if (!context.mounted) return;
    categoriesProvider.init(context, user);
    productsProvider.init(context, user);

    getCategories();
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

  Future<List<Product>> getProducts(String idCategory, String productName) async {
    if (productName.isEmpty) {
      return await productsProvider.getByCategory(idCategory);
    }
    else {
      return await productsProvider.getByCategoryAndProductName(idCategory, productName);
    }
  }

  void getCategories() async {
    categories = await categoriesProvider.getAll();
    refresh();
  }

  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientProductsDetailPage(product: product)
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
}
