import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                _textComedorUtt(),
                _imageBanner(),
                _textFieldUser(),
                _textFieldPassword(),
                _buttonLogin(),
                _textDontHaveAccount()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _textComedorUtt() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Comedor ',
            style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            'UT',
            style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            'T',
            style: TextStyle(
              color: MyColors.secondaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(
          top: 25, bottom: MediaQuery.of(context).size.height * 0.10),
      child: Image.asset(
        'assets/img/icon.png',
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _textFieldUser() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: const TextField(
        decoration: InputDecoration(
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

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: const TextField(
        decoration: InputDecoration(
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

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text('Ingresar'),
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          '¿No tienes cuenta?',
          // Might delete textstyle
          style: TextStyle(color: MyColors.primaryColor),
        ),
        SizedBox(width: 7),
        Text(
          'Registrate',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: MyColors.primaryColor),
        )
      ],
    );
  }
}
