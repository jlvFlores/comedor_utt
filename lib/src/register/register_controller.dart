import 'package:flutter/material.dart';

class RegisterController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController userCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future? init(BuildContext context) {
    this.context = context;
    return null;
  }

  void goToLoginPage() {
    Navigator.pushNamed(context!, 'login');
  }

  void register() {
    String email = emailController.text.trim();
    String userCode = userCodeController.text.trim();
    String name = nameController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
  
    print(email);
    print(userCode);
    print(name);
    print(password);
    print(confirmPassword);  
  }
}
