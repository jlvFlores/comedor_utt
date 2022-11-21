import 'package:comedor_utt/src/pages/diner/categories/create/diner_categories_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:flutter/scheduler.dart';

class DinerCategoriesCreatePage extends StatefulWidget {
  const DinerCategoriesCreatePage({super.key});

  @override
  State<DinerCategoriesCreatePage> createState() => _DinerCategoriesCreatePageState();
}

class _DinerCategoriesCreatePageState extends State<DinerCategoriesCreatePage> {
  
  DinerCategoriesCreateController con = DinerCategoriesCreateController();

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
        title: const Text('Nueva categoria'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          textFieldCategoryName(),
          textFieldDescripcion()
        ],
      ),
      bottomNavigationBar: buttonCreate(),
    );
  }

  Widget textFieldCategoryName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.nameController,
        decoration: const InputDecoration(
          hintText: 'Nombre de la categoria',
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            Icons.list_alt,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }

  Widget textFieldDescripcion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
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
          hintText: 'Descripcion de la categoria',
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

  Widget buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: con.createCategory,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text('Crear categoria'),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}