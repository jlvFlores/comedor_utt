import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/provider/users_provider.dart';
import 'package:comedor_utt/src/utils/my_snackbar.dart';

class LoginController {
  BuildContext? context;
  TextEditingController userCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() async {
    String userCode = userCodeController.text.trim();
    String password = passwordController.text.trim();

    ResponseApi? responseApi = await usersProvider.login(userCode, password);

    if (responseApi != null) {
      MySnackBar.show(context!, '${responseApi.message}');
    }

    // print('Respuesta object: $responseApi');
    // print('Respuesta: ${responseApi!.toJson()}');
  }
}
