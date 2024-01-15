import 'package:flutter/material.dart';

class MedicalRecord extends StatelessWidget {
  const MedicalRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        iconTheme: IconThemeData(color: Color(0XFFBE83B2)),
        title: const Text('Medical Records'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0XFFBE83B2)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Color.fromARGB(255, 255, 255, 255),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Hewan Peliharaan Anda Mengalami Diare',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Hewan peliharaan Anda menderita diare dan membutuhkan obat diare untuk menyembuhkannya. Obat-obatan dapat dipesan di tempat kami.',
              style: TextStyle(fontSize: 15),
            ),
            Divider(height: 23, color: Colors.blueGrey, thickness: 1.0),

            // SizedBox(height: 5),
            Text(
              'Hewan Peliharaan Anda Terluka',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Hewan peliharaan anda terluka karena tertabrak sepeda motor. Obat-obatan dapat dipesan di tempat kami.',
              style: TextStyle(fontSize: 15),
            ),
            Divider(height: 23, color: Colors.blueGrey, thickness: 1.0)
          ],
        ),
      ),
    );
  }
}
