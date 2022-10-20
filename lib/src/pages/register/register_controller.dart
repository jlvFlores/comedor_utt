import 'package:comedor_utt/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/provider/users_provider.dart';

class RegisterController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController userCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  Future? init(BuildContext context) {
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
      MySnackBar.show(context!, 'Debes ingresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      MySnackBar.show(context!, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      MySnackBar.show(context!, 'Contraseña debe tener al menos 6 caracteres');
      return;
    }

    User user = User(
        id: '',
        email: email,
        userCode: userCode,
        name: name,
        password: password,
        sessionToken: '');

    ResponseApi? responseApi = await usersProvider.create(user);

    if (responseApi != null){
      MySnackBar.show(context!, '${responseApi.message}');
    } else {
      //Delete later
      //check conexion or user already exist
      MySnackBar.show(context!, 'Usuario existe o el servidor está inactivo');
    }

    print('RESPUESTA: ${responseApi?.toJson()}');
    print(email);
    print(userCode);
    print(name);
    print(password);
    print(confirmPassword);
  }

  void goToLoginPage() {
    Navigator.pushNamed(context!, 'login');
  }

  // void back() {
  //   Navigator.pop(context!);
  // }
}
