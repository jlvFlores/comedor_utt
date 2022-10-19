import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:comedor_utt/src/api/enviroment.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:http/http.dart' as http;

class UsersProvider {
  final String _url = Enviroment.API_DELIVERY;
  final String _api = '/api/users';

  BuildContext? context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<ResponseApi?> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {
        'Content-type': 'application/json',
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } 
    catch (e) {
      print('Error: $e');
      return null;
    }

  }
}
