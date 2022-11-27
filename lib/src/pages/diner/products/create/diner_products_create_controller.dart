import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:comedor_utt/src/models/category.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/provider/categories_provider.dart';
import 'package:comedor_utt/src/provider/products_provider.dart';
import 'package:comedor_utt/src/utils/my_snackbar.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';

class DinerProductsCreateController {
  
  BuildContext context;
  Function refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController();

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();
  // ImagePicker imagePicker = ImagePicker();

  User user;
  SharedPref sharedPref = SharedPref();

  List<Category> categories = [];
  String idCategory; // ALAMCENAR EL ID DE LA CATEGORIA SELCCIONADA

  // IMAGENES
  PickedFile pickedFile;
  File imageFile1;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));

    if (!context.mounted) return;
    categoriesProvider.init(context, user);
    productsProvider.init(context, user);
    getCategories();
  }

  void getCategories() async {
    categories = await categoriesProvider.getAll();
    refresh();
  }

  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;
    double price = priceController.numberValue;

    if (name.isEmpty || description.isEmpty || price == 0) {
      MySnackBar.show(context, 'Debe ingresar todos los datos');
      return;
    }

    if (imageFile1 == null) {
      MySnackBar.show(context, 'Selecciona una imagene');
      return;
    }

    if (idCategory == null) {
      MySnackBar.show(context, 'Selecciona la categoria del producto');
      return;
    }

    Product product = Product(
      name: name,
      description: description,
      image1: '',
      price: price,
      idCategory: int.parse(idCategory)
    );

    List<File> images = [];
    images.add(imageFile1);

    Stream stream = await productsProvider.create(product, images);
    stream?.listen((res) {
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackBar.show(context, responseApi.message);

      if (responseApi.success == true) {
        resetValues();
      }
    });

    print('Formulario Producto: ${product.toJson()}');
  }

  void resetValues() {
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '0.0';
    imageFile1 = null;
    idCategory = null;
    refresh();
  }

  Future selectImage(ImageSource imageSource, int fileNumber) async {
    
    // pickedFile = await imagePicker.pickImage(source: imageSource);
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      if (fileNumber == 1) {
        imageFile1 = File(pickedFile.path);
      }
    }
    if (!context.mounted) return;
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int fileNumber) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery, fileNumber);
        },
        child: const Text('GALERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera, fileNumber);
        },
        child: const Text('CAMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      }
    );
  }
}
