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

  Future<User?> getById(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByUserId/$id');
      Map<String, String> headers = {
        'Content-type': 'application/json',
      };
      final res = await http.get(url, headers: headers);

      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {
        'Content-type': 'application/json'
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

  Future<ResponseApi?> update(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/update');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.put(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } 
    catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> logout(String idUser) async {
    try {
      Uri url = Uri.http(_url, '$_api/logout');
      String bodyParams = json.encode({
        'id' : idUser
      });
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> login(String userCode, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({
        'user_code': userCode,
        'password': password
      });
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }
}
