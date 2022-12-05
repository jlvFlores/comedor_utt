// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:comedor_utt/src/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) == null) return null;

    return await json.decode(prefs.getString(key));
  }

  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  void logout(BuildContext context, String idUser) async {
    UsersProvider usersProvider = UsersProvider();
    usersProvider.init(context);
    await usersProvider.logout(idUser);
    await remove('user');
    // if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }
}
