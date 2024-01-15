import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostServices {
  final dio = Dio();
  final url = "http://192.168.1.4:8000/api";

  getPosts() async {
    try {
      var response = await dio.get("$url/posts",
          options: Options(headers: {"Content-Type": "application/json"}));

      Map obj = response.data;

      if (obj['status']) {
        return {"status": true, "data": obj['data']};
      } else {
        return {"status": false, "messsage": obj['message']};
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  getPostsByUser() async {
    try {
      var response = await dio.get("$url/posts?id-user=1",
          options: Options(headers: {"Content-Type": "application/json"}));

      Map obj = response.data;

      if (obj['status']) {
        return {"status": true, "data": obj['data']};
      } else {
        return {"status": false, "message": obj['message']};
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  addPost({required String title, required String deskripsi}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final idUser = jsonDecode(prefs.getString("user")!)['user']['id'];

      var response = await dio.post("$url/posts",
          data: {"title": title, "deskripsi": deskripsi, "id_user": idUser},
          options: Options(headers: {"Content-Type": "application/json"}));

      Map obj = response.data;
      print(obj);
      if (obj['status']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  deletePost({required int idPost}) async {
    try {
      var response = await dio.delete("$url/posts/$idPost");

      Map obj = response.data;

      if (obj['status']) {
        return {"status": true, "data": obj['data']};
      } else {
        return {"status": false, "message": obj['message']};
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  addComment(
      {required String deskripsi,
      required int idPost,
      required int idUser}) async {
    try {
      var response = await dio.post("$url/comments",
          data: {"deskripsi": deskripsi, "id_post": idPost, "id_user": idUser},
          options: Options(headers: {"Content-Type": "application/json"}));

      Map obj = response.data;
      print(obj);
      if (obj['status']) {
        return {"status": true, "data": obj['data']};
      } else {
        return {"status": false, "message": obj['message']};
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  deleteComment({required int idComment}) async {
    try {
      var response = await dio.delete("$url/comments/$idComment");

      Map obj = response.data;

      if (obj['status']) {
        return {"status": true, "data": obj['data']};
      } else {
        return {"status": false, "message": obj['message']};
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }
}
