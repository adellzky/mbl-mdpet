import 'package:flutter/material.dart';
import 'package:pbl_mobile/PostPage.dart';
import 'package:pbl_mobile/model/api.dart';
import 'package:pbl_mobile/layanan/homescreen.dart';
import 'package:pbl_mobile/layanan/katalog.dart';
import 'package:pbl_mobile/profile/profiledisplay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> dataKatalog = [];

  getKatalog() async {
    final data = await Api().fetchData();
    for (var item in data) {
      dataKatalog.add(item);
    }
    print(data);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getKatalog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Expanded(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   padding: EdgeInsets.only(bottom: 20, top: 25),
            //   child:
            Image.asset(
              'assets/logo.png',
              // width: 150.0,
              height: 100.0,
            ),
            // ),
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
                                  builder: (context) => PostPage()),
                            );
                          },
                          child: const Icon(
                            Icons.help,
                            color: Colors.white,
                            size: 35,
                          ),
                        )),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    const Text(
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
                        decoration: const BoxDecoration(
                            color: Color(0XFFBE83B2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DisplayProfile()),
                            );
                          },
                          child: const Icon(
                            Icons.person_sharp,
                            color: Colors.white,
                            size: 35,
                          ),
                        )),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    const Text(
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
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Image.asset(
                'assets/vaksin.jpg',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Produk dan Layanan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0XFFBE83B2),
                  ),
                ),
                TextButton(
                    child: const Row(
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    })
              ],
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dataKatalog.length,
                itemBuilder: (context, index) {
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                  );
                  return Card(
                    // margin: EdgeInsets.only(bottom: 500.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "${dataKatalog[index]['image']}",
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dataKatalog[index]['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    // color: Colors.purpleAccent,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    dataKatalog[index]['deskripsi'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    "Rp. ${dataKatalog[index]['price']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
