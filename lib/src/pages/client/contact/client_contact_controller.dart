// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:comedor_utt/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ClientContactController {
  BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController userCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String serviceId = 'service_qfbwrqb';
  String templateId = 'template_pmy9wyn';
  String userId = 'YV2UmkI69hHjKaCJn';

  Future init(BuildContext context) {
    this.context = context;
    return null;
  }

  Future send() async {
    String email = emailController.text.trim();
    String userCode = userCodeController.text.trim();
    String name = nameController.text;
    String message = messageController.text;
    

    if (email.isEmpty || userCode.isEmpty || name.isEmpty || message.isEmpty) {
      MySnackBar.show(context, 'Por favor ingresa todos los campos');
    } else {

      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-type': 'application/json'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_email': email,
            'user_name': name,
            'user_code': userCode,
            'user_message': message,
          }
        })
      );

      print(response.body);

      Fluttertoast.showToast(msg: 'Tu mensaje ha sido enviado');

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  void back() {
    Navigator.pop(context);
  }
}
