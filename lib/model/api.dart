import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbl_mobile/layanan/katalog.dart';

class Api {
  final dio = Dio();
  final url = "http://127.0.0.1:8000/api";

  Future<List<dynamic>> fetchData() async {
    final response = await dio.get("$url/products");

    if (response.statusCode == 200) {
      final List<dynamic> katalog = response.data['data'];

      return katalog;
    } else {
      throw Exception('Gagal mengambil data dari API');
    }
  }
}
