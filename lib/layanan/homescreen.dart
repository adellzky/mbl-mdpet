import 'package:flutter/material.dart';
import 'package:pbl_mobile/co.dart';
import 'package:pbl_mobile/model/TransaksiServices.dart';
import 'dart:convert';
import 'package:pbl_mobile/model/api.dart';
import 'package:pbl_mobile/layanan/katalog.dart';
import 'package:pbl_mobile/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
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
          // IconButton(
          //   color: Colors.purpleAccent,
          //   icon: Icon(Icons.shopping_cart),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ShoppingCartPage(),
          //       ),
          //     );
          //   },
          // ),
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
                            onPressed: () async {
                              // _addToCart(dataKatalog[index]);
                              // print("${dataKatalog[index]}");
                              var response = await TransaksiServices()
                                  .postOrder(
                                      idProduk: dataKatalog[index]['id']);

                              if (response['status']) {
                                print("Order Sukses");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckoutPage()),
                                );
                              } else {
                                print("Order Failed!");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purpleAccent),
                            child: const Text(
                              'Order Now!',
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

  void _addToCart(katalog) async {
    // setState(() {
    //   ShoppingCartPage.shoppingCart.add(Katalog);
    // });
    print(katalog);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? chartString = prefs.getString("chart");
    List<dynamic> chart = chartString != null ? jsonDecode(chartString) : [];

    // print("Ini data baru ${[...chart, katalog]}");
    // prefs.setString("chart", jsonEncode([...chart, katalog]));
    print(chart);
    print(chartString);

    // if (chart != null) {
    // } else {
    //   // Assuming katalog is a JSON-serializable object
    //   prefs.setString("chart", jsonEncode([katalog]));
    // }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('${katalog.name} ditambahkan ke dalam keranjang.'),
    //   ),
    // );
  }
}

class ShoppingCartPage extends StatefulWidget {
  static List<Katalog> shoppingCart = [];

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<dynamic> shoppingCart = [];

  getChart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shoppingCart = jsonDecode(prefs.getString("chart")!);
    print(shoppingCart);
    setState(() {});
  }

  void _removeItem(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shoppingCart.removeAt(index);
    prefs.setString("chart", "$shoppingCart");
    print("$shoppingCart");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getChart();
  }

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
                var item = shoppingCart[index];

                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item['image'],
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
                                item['name'],
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
                                  item['deskripsi'],
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
                                  'Harga : ${item['price']}',
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
}
