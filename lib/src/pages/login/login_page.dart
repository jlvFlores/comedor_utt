import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/pages/login/login_controller.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
// import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController con = LoginController();

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              textComedorUtt(),
              // loadingAnimation(),
              imageBanner(),
              textFieldUserCode(),
              textFieldPassword(),
              buttonLogin(),
              textDontHaveAccount()
            ],
          ),
        ),
      ),
    );
  }

  Widget textComedorUtt() {
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

  Widget imageBanner() {
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
            hintText: 'Matricula/No. Empleado',
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

  Widget buttonLogin() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: con.login,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text('Ingresar'),
      ),
    );
  }

  Widget textDontHaveAccount() {
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
            onTap: con.goToRegisterPage,
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
