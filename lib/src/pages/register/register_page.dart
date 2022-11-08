import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/pages/register/register_controller.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController con = RegisterController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  textRegister(),
                  imageUser(),
                  textFieldEmail(),
                  textFieldUserCode(),
                  textFieldName(),
                  textFieldPassword(),
                  textFieldConfirmPassword(),
                  buttonRegister(),
                  textBack(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget textRegister() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Registro ',
            style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget imageUser() {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 15),
      child: CircleAvatar(
        backgroundImage: const AssetImage('assets/img/user_profile_2.png'),
        radius: 60,
        backgroundColor: Colors.grey[200]
      ),
    );
  }

  Widget textFieldEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            hintText: 'Correo electronico',
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.mail,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }
    Widget textFieldUserCode() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: con.userCodeController,
        // keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Matricula',
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }
    Widget textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: con.nameController,
        // keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Nombre',
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.face,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: con.passwordController,
        obscureText: true,
        // keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Contraseña',
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget textFieldConfirmPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: con.confirmPasswordController,
        obscureText: true,
        // keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Confirma Contraseña',
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget buttonRegister() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: con.register,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text('Registrarse'),
      ),
    );
  }

  Widget textBack() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: con.back,
            child: const Text(
              'Regresar',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: MyColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
