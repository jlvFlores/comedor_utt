import 'package:flutter/material.dart';
import 'package:comedor_utt/src/utils/my_snackbar.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/provider/users_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

// TO UPDATE MORE FIELDS
// You need to add a new TextEditingController controller and add it in Future
// add it's string in update function, verify if empty, and change myUser fields 

class ClientUpdateController {
  BuildContext? context;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  late User user;
  SharedPref sharedPref = SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    usersProvider.init(context);
    user = User.fromJson(await sharedPref.read('user'));
    nameController.text = user.name!;
    emailController.text = user.email!;
    return null;
  }

  void update() async {
    String name = nameController.text;
    String email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      MySnackBar.show(context!, 'Debes ingresar todos los campos');
      return;
    }

    User myUser = User(
        id: user.id,
        userCode: user.userCode,
        name: name,
        email: email,
        password: user.password,
        sessionToken: user.sessionToken,
        roles: user.roles
    );

    ResponseApi? responseApi = await usersProvider.update(myUser);
    Fluttertoast.showToast(msg: '${responseApi?.message}');

    if (responseApi?.success == true) {
      user = (await usersProvider.getById(myUser.id!))!; // OBTENIENDO EL USUARIO DE LA DB
      print('Usuario obtenido: ${user.toJson()}');
      sharedPref.save('user', user.toJson());
      Navigator.pushNamedAndRemoveUntil(context!, 'client/products/list', (route) => false);
    }
  }

  void back() {
    Navigator.pop(context!);
  }
}
