import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final dio = Dio();
  var endpoint = "http://localhost:8000/api";

  login({required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await dio.post('$endpoint/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }));

    Map obj = response.data;
    if (response.statusCode == 200) {
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

    var response = await dio.post('$endpoint/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'confirm_password': confirm_password,
        },
        options: Options(headers: {"Content-Type": "application/json"}));

    Map userData = response.data;
    if (response.statusCode == 200) {
      prefs.setString('user', jsonEncode(userData));
      return true;
    } else {
      return false;
    }
  }
}