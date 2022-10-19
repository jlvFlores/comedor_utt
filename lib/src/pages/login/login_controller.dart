import 'package:flutter/material.dart';

class LoginController {
  BuildContext? context;
  TextEditingController userCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future? init(BuildContext context) {
    this.context = context;
    return null;
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() {
    String userCode = userCodeController.text.trim();
    String password = passwordController.text.trim();

    print('USER CODE: $userCode');
    print('PASSWORD: $password');
  }
}
