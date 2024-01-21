import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiServices {
  final dio = Dio();
  final url = "http://127.0.0.1:8000/api";

  getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUser = jsonDecode(prefs.getString("user")!)['id'];

    var response = await dio.get("$url/order?id-user=$idUser",
        options: Options(headers: {"Content-Type": "application/json"}));

    Map obj = response.data;

    if (obj['status']) {
      return {"status": true, "data": obj['data']};
    } else {
      return {"status": false, "message": obj['message']};
    }
  }

  postOrder({required int idProduk}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUser = jsonDecode(prefs.getString("user")!)['user']['id'];

    var response = await dio.post("$url/orders",
        data: {
          "id_cust": idUser,
          "id_product": idProduk,
          "jumlah_pembelian": 1
        },
        options: Options(headers: {"Content-Type": "application/json"}));

    Map obj = response.data;
    print(idUser);
    print(obj);
    if (obj['status']) {
      return {"status": true, "data": obj['data']};
    } else {
      return {"status": false, "message": obj['message']};
    }
  }
}
