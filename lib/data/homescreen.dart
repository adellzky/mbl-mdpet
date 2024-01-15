import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pbl_mobile/data/api.dart';
import 'package:pbl_mobile/data/katalog.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    getKatalog();
  }

  // Future<void> fetchData() async {
  //   final response = await http.get(
  //       Uri.parse('https://example.com/api/Katalog')); // Ganti URL sesuai API Anda

  //   if (response.statusCode == 200) {
  //     final List<dynamic> responseData = json.decode(response.body);
  //     setState(() {
  //       dataKatalog = responseData.map((json) => Katalog.fromJson(json)).toList();
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
          color: Colors.purpleAccent,
        ),
        title: Text(
          "KATALOG",
          style: TextStyle(
            color: Colors.purpleAccent,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 0.15)),
          IconButton(
            color: Colors.purpleAccent,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartPage(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: dataKatalog.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        "${dataKatalog[index]['image']}",
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataKatalog[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Colors.purpleAccent,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              dataKatalog[index]['deskripsi'],
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Rp ${dataKatalog[index]['price']}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () {
                              _addToCart(dataKatalog[index]);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purpleAccent),
                            child: const Text(
                              'Masukkan Keranjang',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _addToCart(Katalog Katalog) {
    setState(() {
      ShoppingCartPage.shoppingCart.add(Katalog);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${Katalog.name} ditambahkan ke dalam keranjang.'),
      ),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  static List<Katalog> shoppingCart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang',
          style: TextStyle(
            color: Colors.purpleAccent,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: shoppingCart.length,
              itemBuilder: (context, index) {
                Katalog item = shoppingCart[index];

                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.purpleAccent,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  item.deskripsi,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Harga : ${item.harga}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _removeItem(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _removeItem(int index) {
    shoppingCart.removeAt(index);
  }
}
