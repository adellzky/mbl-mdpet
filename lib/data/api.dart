import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbl_mobile/data/katalog.dart';

class Api {
  final dio = Dio();
  final url = "http://localhost:8000/api";

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
