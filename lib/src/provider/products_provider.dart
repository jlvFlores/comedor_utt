// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:comedor_utt/src/api/environment.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/models/user.dart';
import 'package:comedor_utt/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductsProvider {

  final String _url = Environment.apiDelivery;
  final String _api = '/api/products';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Product>> getByCategory(String idCategory) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        // if (!context.mounted) return null;
        SharedPref().logout(context, sessionUser.id);
      }
      final data = json.decode(res.body); // CATEGORIAS
      Product product = Product.fromJsonList(data);
      return product.toList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Product>> getByCategoryAndProductName(String idCategory, String productName) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByCategoryAndProductName/$idCategory/$productName');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        // if (!context.mounted) return null;
        SharedPref().logout(context, sessionUser.id);
      }
      final data = json.decode(res.body); // CATEGORIAS
      Product product = Product.fromJsonList(data);
      return product.toList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Stream> create(Product product, List<File> images) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser.sessionToken;

      for (int i = 0; i < images.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)
        ));
      }

      request.fields['product'] = json.encode(product);
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }

}