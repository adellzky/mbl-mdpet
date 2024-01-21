import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbl_mobile/model/PostServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  var posts = [];
  int idUser = 0;

  getPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idUser = jsonDecode(prefs.getString("user")!)['user']['id'];
    print(
        "Ini data user: ${jsonDecode(prefs.getString("user")!)['user']['id']}");
    var response = await PostServices().getPosts();

    posts = response['data'];
    print("Ini data user: $idUser");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Consultation",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0XFFBE83B2),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                  hintText: "Title consultation",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2))),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              controller: description,
              decoration: InputDecoration(
                  hintText: "Description consultation",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2))),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () async {
                var response = await PostServices()
                    .addPost(title: title.text, deskripsi: description.text);

                if (response) {
                  await getPosts();
                  title.clear();
                  description.clear();
                  print("Data post");
                } else {
                  print("Data post failed!");
                }
              },
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0XFFBE83B2),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Post Consultation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (_, index) {
                    TextEditingController comment = TextEditingController();
                    return Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            top: BorderSide(color: Colors.deepPurple, width: 2),
                            left:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            right:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          )),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              posts[index]['title'],
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              posts[index]['deskripsi'],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                "Comments (${posts[index]['comments'].length})",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 8,
                            ),
                            ListView.builder(
                                itemCount: posts[index]['comments'].length,
                                shrinkWrap: true,
                                itemBuilder: (_, i) {
                                  final comments = posts[index]['comments'][i];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comments['users']['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(comments['deskripsi'])
                                      ],
                                    ),
                                  );
                                }),
                            posts[index]['id_user'] == idUser
                                ? Column(
                                    children: [
                                      TextField(
                                        controller: comment,
                                        decoration: InputDecoration(
                                            hintText: "Your comments",
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 5),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple,
                                                    width: 2))),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          var response = await PostServices()
                                              .addComment(
                                                  deskripsi: comment.text,
                                                  idPost: posts[index]['id'],
                                                  idUser: idUser);

                                          if (response['status']) {
                                            await getPosts();
                                            print("Add comment success!");
                                            comment.clear();
                                            return;
                                          } else {
                                            print("Add comment failed!");
                                            return;
                                          }
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              color: Color(0XFFBE83B2),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.all(6),
                                          child: Text(
                                            "Add Comment",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox.shrink()
                          ]),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
