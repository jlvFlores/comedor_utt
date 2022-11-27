import 'package:flutter/material.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:comedor_utt/src/pages/login/login_page.dart';
import 'package:comedor_utt/src/pages/register/register_page.dart';
import 'package:comedor_utt/src/pages/roles/roles_page.dart';
import 'package:comedor_utt/src/pages/client/products/list/client_products_list_page.dart';
import 'package:comedor_utt/src/pages/client/update/client_update_page.dart';
import 'package:comedor_utt/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:comedor_utt/src/pages/diner/orders/list/diner_orders_list_page.dart';
import 'package:comedor_utt/src/pages/diner/categories/create/diner_categories_create_page.dart';
import 'package:comedor_utt/src/pages/diner/products/create/diner_products_create_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
    const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comedor Utt',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'register': (BuildContext context) => const RegisterPage(),
        'roles': (BuildContext context) => const RolesPage(),
        'client/products/list': (BuildContext context) => const ClientProductsListPage(),
        'client/update': (BuildContext context) => const ClientUpdatePage(),
        'client/orders/create': (BuildContext context) => const ClientOrdersCreatePage(),
        'diner/orders/list': (BuildContext context) => const DinerOrdersListPage(),
        'diner/categories/create': (BuildContext context) => const DinerCategoriesCreatePage(),
        'diner/products/create': (BuildContext context) => const DinerProductsCreatePage()
      },
      theme: ThemeData(
        // fontFamily: 'Roboto',
        primaryColor: MyColors.primaryColor,
        colorScheme: const ColorScheme.light(primary: MyColors.primaryColor),
        appBarTheme: const AppBarTheme(elevation: 0)
      ),
    );
  }
}
