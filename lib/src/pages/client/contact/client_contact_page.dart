import 'package:comedor_utt/src/pages/client/contact/client_contact_controller.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientContactPage extends StatefulWidget {
  const ClientContactPage({Key key}) : super(key: key);

  @override
  State<ClientContactPage> createState() => _ClientContactPageState();
}

class _ClientContactPageState extends State<ClientContactPage> {
  ClientContactController con = ClientContactController();

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
                const SizedBox(height: 10),
                textContact(),
                const SizedBox(height: 50),
                textFieldEmail(),
                textFieldName(),
                textFieldUserCode(),
                textFieldComment(),
                buttonSend(),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: iconBack(),
          ),
        ],
      ),
    ));
  }

  Widget iconBack() {
    return IconButton(
        onPressed: con.back,
        icon: const Icon(Icons.arrow_back_ios, color: MyColors.primaryColor));
  }

  Widget textContact() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Contactanos',
            style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ],
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
        textCapitalization: TextCapitalization.characters,
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

  Widget textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: con.nameController,
        textCapitalization: TextCapitalization.words,
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

  Widget textFieldComment() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.messageController,
        textCapitalization: TextCapitalization.sentences,
        maxLines: 10,
        decoration: const InputDecoration(
          hintText: 'Díganos cómo podemos mejorar nuestros servicios o si encuentra un error, háganoslo saber.',
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.description_outlined,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }


  Widget buttonSend() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: con.send,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text('Enviar'),
      ),
    );
  }
}
