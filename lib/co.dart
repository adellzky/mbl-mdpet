import 'package:flutter/material.dart';
import 'package:pbl_mobile/layanan/katalog.dart';

class CheckoutPage extends StatelessWidget {
  static List<Katalog> shoppingCart = [];
  static int purchaseNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout Status'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Pembelian:',
              style: TextStyle(fontSize: 15),
            ),
            // Tambahkan kondisi if-else untuk menampilkan status pembelian

            Column(
              children: [
                Text(
                  'Pembelian Sukses!',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // Text('Nomor Pembelian: #$purchaseNumber'),
                SizedBox(height: 5),
                Text(
                  'Tolong tunjukan nomor pembelian saat Anda menemui kasir',
                  style: TextStyle(fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20),
              ],
            ),
            // Text(
            //   'Pembelian Gagal. Keranjang belanja kosong.',
            //   style: TextStyle(
            //     color: Colors.red,
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     performCheckout(context);
            //   },
            //   child: Text('Lakukan Checkout'),
            // ),
            // SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali ke Produk'),
            ),
          ],
        ),
      ),
    );
  }

  void performCheckout(BuildContext context) {
    purchaseNumber++;
    shoppingCart.clear();
    Navigator.pop(context);
  }
}
