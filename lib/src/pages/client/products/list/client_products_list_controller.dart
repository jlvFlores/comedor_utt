import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientProductsListController {
  BuildContext? context;
  SharedPref sharedPref = SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
  }

  logout() {
    sharedPref.logout(context!);
  }
}
