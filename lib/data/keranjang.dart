import 'package:flutter/material.dart';
import 'package:pbl_mobile/data/Katalog.dart';

class ShoppingCartPage extends StatefulWidget {
  final List<String> shoppingCart;
  final List<Katalog> dataKatalog;

  const ShoppingCartPage({
    Key? key,
    required this.shoppingCart,
    required this.dataKatalog,
  }) : super(key: key);

  @override
  _ShoppingCartPageState createState() =>
      _ShoppingCartPageState(shoppingCart, dataKatalog);
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<String> shoppingCart;
  List<Katalog> dataKatalog;

  _ShoppingCartPageState(this.shoppingCart, this.dataKatalog);

  @override
  Widget build(BuildContext context) {
    int totalHarga = _calculateTotalHarga();

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
                String itemName = shoppingCart[index];
                String itemImage = dataKatalog[index % dataKatalog.length].image;
                int itemPrice = dataKatalog[index % dataKatalog.length].harga;

                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            itemImage,
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
                                itemName,
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
                                  '${dataKatalog[index % dataKatalog.length].deskripsi}',
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
                                  'Harga : $itemPrice',
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
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga: $totalHarga',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _checkout();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Text('Checkout',
                      style: TextStyle(
                          fontFamily: 'Poppins', color: Colors.purpleAccent)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _calculateTotalHarga() {
    int totalHarga = 0;
    for (int i = 0; i < shoppingCart.length; i++) {
      totalHarga += dataKatalog[i % dataKatalog.length].harga;
    }
    return totalHarga;
  }

  void _removeItem(int index) {
    setState(() {
      shoppingCart.removeAt(index);
    });
  }

  void _checkout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Checkout'),
          content: Text('Anda yakin ingin checkout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _completeCheckout();
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  void _completeCheckout() {
    // Lakukan tindakan yang diperlukan saat checkout
    setState(() {
      shoppingCart.clear(); // Kosongkan keranjang
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Checkout berhasil.'),
      ),
    );
  }
}
