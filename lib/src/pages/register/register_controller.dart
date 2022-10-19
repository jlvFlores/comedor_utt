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

    User user = User(
      id: '',
      email: email,
      userCode: userCode,
      name: name,
      password: password, 
      sessionToken: ''
    );
    
    ResponseApi? responseApi = await usersProvider.create(user);

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
