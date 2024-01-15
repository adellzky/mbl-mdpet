import 'package:flutter/material.dart';
import 'package:pbl_mobile/ChatScreen.dart';
import 'package:pbl_mobile/MedicalRecord.dart';
import 'package:pbl_mobile/PostPage.dart';
import 'package:pbl_mobile/grooming/grooming.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(23),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 20, top: 25),
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: BoxDecoration(
                              color: Color(0XFFBE83B2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicalRecord()),
                              );
                            },
                            child: Icon(
                              Icons.query_builder_sharp,
                              color: Colors.white,
                              size: 35,
                            ),
                          )),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        "Riwayat",
                        style: TextStyle(
                            color: Color(0XFF818181),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: BoxDecoration(
                              color: Color(0XFFBE83B2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostPage()),
                              );
                            },
                            child: Icon(
                              Icons.help,
                              color: Colors.white,
                              size: 35,
                            ),
                          )),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        "Konsultasi",
                        style: TextStyle(
                            color: Color(0XFF818181),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: BoxDecoration(
                              color: Color(0XFFBE83B2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicalRecord()),
                              );
                            },
                            child: Icon(
                              Icons.person_sharp,
                              color: Colors.white,
                              size: 35,
                            ),
                          )),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: Color(0XFF818181),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 50, bottom: 40),
                child: Image.asset(
                  'assets/vaksin.jpg',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Produk dan Layanan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0XFFBE83B2),
                    ),
                  ),
                  TextButton(
                      child: Row(
                        children: [
                          Text(
                            "Lainnya",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 145, 139, 139)),
                          ),
                          Icon(Icons.navigate_next_rounded,
                              color: Color.fromARGB(255, 145, 139, 139)),
                        ],
                      ),
                      onPressed: () {})
                ],
              )
            ],
          )),
    ));
  }
}
