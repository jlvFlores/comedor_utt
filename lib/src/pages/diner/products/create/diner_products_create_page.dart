import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/models/category.dart';
import 'package:comedor_utt/src/pages/diner/products/create/diner_products_create_controller.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';

class DinerProductsCreatePage extends StatefulWidget {
  const DinerProductsCreatePage({super.key});

  @override
  State<DinerProductsCreatePage> createState() => _DinerProductsCreatePageState();
}

class _DinerProductsCreatePageState extends State<DinerProductsCreatePage> {
  
  DinerProductsCreateController con = DinerProductsCreateController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo producto'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          textFieldName(),
          textFieldDescripcion(),
          textFieldPrice(),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cardImage(con.imageFile1, 1),
                cardImage(con.imageFile2, 2),
                cardImage(con.imageFile3, 3),
              ],
            ),
          ),
          dropDownCategories(con.categories)
        ],
      ),
      bottomNavigationBar: buttonCreate(),
    );
  }

  Widget textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.nameController,
        maxLines: 1,
        maxLength: 180,
        decoration: const InputDecoration(
          hintText: 'Nombre del producto',
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            Icons.local_pizza,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }

  Widget textFieldDescripcion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.descriptionController,
        maxLines: 4,
        maxLength: 255,
        decoration: const InputDecoration(
          hintText: 'Descripcion del producto',
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            Icons.description_outlined,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget textFieldPrice() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.priceController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: const InputDecoration(
          hintText: 'Precio',
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            Icons.monetization_on,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }

  Widget cardImage(File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        con.showAlertDialog(numberFile);
      },
      child: imageFile != null
      ? Card(
        elevation: 3.0,
        child: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.25,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          )
        )
      ) 
      : Card(
        elevation: 3.0,
        child: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.25,
          child: const Image (
            image: AssetImage('assets/img/add_image.png')
          )
        )
      ),
    );
  }

  Widget dropDownCategories(List<Category> categories) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.search,
                      color: MyColors.primaryColor
                    ),
                    SizedBox(width: 15,),
                    Text(
                      'Categorias',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      ),
                    ),
                  ]
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    underline: Container(
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: MyColors.primaryColor,
                      ),
                    ),
                    elevation: 3,
                    isExpanded: true,
                    hint: const Text(
                      'Seleccionar categoria',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      ),
                    ),
                    items: dropDownItems(categories),
                    value: con.idCategory,
                    onChanged: (option) {
                    setState(() {
                      print('Categoria seleccionda $option');
                      con.idCategory = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                    });
                  },
                  ),
                )
              ],
            )
          ),
      ),
    );
  }

  List<DropdownMenuItem<String>> dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    for (var category in categories) {
      list.add(DropdownMenuItem(
        value: category.id,
        child: Text('${category.name}')
      ));
    }

    return list;
  }

  Widget buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: con.createProduct,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text('Crear producto'),
      ),
    );
  }


  void refresh() {
    setState(() {});
  }

}
