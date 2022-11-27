import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:comedor_utt/src/api/environment.dart';
import 'package:comedor_utt/src/models/response_api.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:http/http.dart' as http;

class UsersProvider {
  final String _url = Environment.apiDelivery;
  final String _api = '/api/users';

  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, {User sessionUser}) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<User> getById(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findById/$id');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) { // No autorizado
        Fluttertoast.showToast(msg: 'Tu session expiro');
        if (!context.mounted) return null;
        SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> create(User user) async {
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

  Future<ResponseApi> update(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/update');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.put(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) { // No autorizado
        Fluttertoast.showToast(msg: 'Tu session expiro');
        if (!context.mounted) return null;
        SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> updateNotificationToken(String idUser, String token) async {
    try {
      Uri url = Uri.http(_url, '$_api/updateNotificationToken');
      String bodyParams = json.encode({
        'id': idUser,
        'notification_token': token
      });
      Map<String, String> headers = {
        'Content-type': 'application/json',
      };
      final res = await http.put(url, headers: headers, body: bodyParams);

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> logout(String idUser) async {
    try {
      Uri url = Uri.http(_url, '$_api/logout');
      String bodyParams = json.encode({
        'id': idUser
      });
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

  Future<ResponseApi> login(String userCode, String password) async {
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
    catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
