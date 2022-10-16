import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/login/login_controller.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
// import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _con = LoginController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
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
                  _textComedorUtt(),
                  // _loadingAnimation(),
                  _imageBanner(),
                  _textFieldUserCode(),
                  _textFieldPassword(),
                  _buttonLogin(),
                  _textDontHaveAccount()
                ],
              ),
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
                fontWeight: FontWeight.bold),
          ),
          Text(
            'UT',
            style: TextStyle(
                color: MyColors.secondaryColor,
                fontFamily: 'Empanada',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          Text(
            't',
            style: TextStyle(
                color: MyColors.primaryColor,
                fontFamily: 'Empanada',
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Widget _loadingAnimation() {
  //   return Container(
  //     margin: EdgeInsets.only(
  //         top: 25, bottom: MediaQuery.of(context).size.height * 0.10),
  //     child: Lottie.asset('assets/json/3dots-loading.json',
  //         width: 200, height: 200, fit: BoxFit.fill),
  //   );
  // }

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

  Widget _textFieldUserCode() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.userCodeController,
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

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordController,
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

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.login,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '¿No tienes cuenta?',
            // Might delete textstyle
            style: TextStyle(color: MyColors.primaryColor),
          ),
          const SizedBox(width: 7),
          GestureDetector(
            onTap: _con.goToRegisterPage,
            child: const Text(
              'Registrate',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: MyColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
