// ignore_for_file: use_build_context_synchronously

import 'package:comedor_utt/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/provider/users_provider.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController userCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  Future init(BuildContext context) {
    this.context = context;
    usersProvider.init(context);
    return null;
  }

  void register() async {
    String email = emailController.text.trim();
    String userCode = userCodeController.text.trim();
    String name = nameController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        userCode.isEmpty ||
        name.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackBar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      MySnackBar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      MySnackBar.show(context, 'Contraseña debe tener al menos 6 caracteres');
      return;
    }

    User user = User(
        id: '',
        email: email,
        userCode: userCode,
        name: name,
        password: password,
        sessionToken: '', 
        roles: []
    );

    ResponseApi responseApi = await usersProvider.create(user);

    // if (!context.mounted) return;
    MySnackBar.show(context, responseApi.message);

    if (responseApi?.success == true) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, 'login');
      });
    }

    print('RESPUESTA: ${responseApi?.toJson()}');
    print(email);
    print(userCode);
    print(name);
    print(password);
    print(confirmPassword);
  }

  void back() {
    Navigator.pop(context);
  }
}
