import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final dio = Dio();
  final url = 'http://127.0.0.1:8000/api';

  login({required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await dio.post("$url/login",
        data: {'email': email, 'password': password},
        options: Options(headers: {
          "Content-Type": "application/json",
        }));

    Map obj = response.data;
    print(obj);
    if (obj['jwt-token'] != null) {
      prefs.setString('token', obj['jwt-token']);
      prefs.setString('user', jsonEncode(obj));
      return true;
    } else {
      return false;
    }
  }

  register(
      {required String name,
      required String email,
      required String password,
      required String confirm_password}) async {
    final prefs = await SharedPreferences.getInstance();

    var response = await dio.post('$url/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'confirm_password': confirm_password,
        },
        options: Options(headers: {"Content-Type": "application/json"}));

    Map userData = response.data;
    print(userData);
    if (response.statusCode == 200) {
      prefs.setString('user', jsonEncode(userData));
      return true;
    } else {
      return false;
    }
  }

  logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.remove('token');
      await prefs.remove('user');

      return true;
    } catch (e) {
      print('Error during logout: $e');
      return false;
    }
  }
}
