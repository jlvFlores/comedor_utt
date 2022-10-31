import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/provider/users_provider.dart';
import 'package:comedor_utt/src/utils/my_snackbar.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';

class LoginController {
  BuildContext? context;
  TextEditingController userCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  SharedPref sharedPref = SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await sharedPref.read('user') ?? {});

    print('User Session Token: ${user.sessionToken}');

    if (user.sessionToken != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() async {
    String userCode = userCodeController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi? responseApi = await usersProvider.login(userCode, password);

    print('Respuesta object: $responseApi');

    if (responseApi!.success == true) {
      User user = User.fromJson(responseApi.data);
      sharedPref.save('user', user.toJson()); // Se almacena el usuario dentro del dispositivo
      Navigator.pushNamedAndRemoveUntil(context!, 'client/products/list', (route) => false);
    } else {
      MySnackBar.show(context!, '${responseApi.message}');
    }
  }
}
