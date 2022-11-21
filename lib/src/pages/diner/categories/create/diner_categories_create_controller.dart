import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/models/category.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/provider/categories_provider.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:comedor_utt/src/utils/my_snackbar.dart';

class DinerCategoriesCreateController {
  BuildContext? context;
  Function? refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CategoriesProvider categoriesProvider = CategoriesProvider();
  User? user;
  SharedPref sharedPref = SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    
    if (!context.mounted) return;
    categoriesProvider.init(context, user!);
  }

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackBar.show(context!, 'Debe ingresar todos los datos');
      return;
    }

    Category category = Category(
      name: name,
      description: description
    );
    ResponseApi? responseApi = await categoriesProvider.create(category);
    
    if (responseApi?.message == null) { // FIGURE OUT WHY MESSAGE RETURNS NULL WHEN SESSION EXPIRES
      MySnackBar.show(context!, 'Tu session expiro');
    } else {
      MySnackBar.show(context!, '${responseApi?.message}');
    }

    if (responseApi?.success == true) {
      nameController.text = '';
      descriptionController.text = '';
    }
  }
}