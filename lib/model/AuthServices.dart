import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final dio = Dio();
  final url = 'http://192.168.1.4:8000/api';

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
}
