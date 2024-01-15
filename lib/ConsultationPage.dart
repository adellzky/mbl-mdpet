import 'package:flutter/material.dart';

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color.fromARGB(255, 164, 48, 118)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Notes'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        titleTextStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 164, 48, 118)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Color.fromARGB(255, 255, 255, 255),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Consultation 01',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Your pet has diarrhea and needs diarrhea medicine to cure it. Medicines can be ordered at our place.',
              style: TextStyle(fontSize: 15),
            ),
            Divider(
                height: 23,
                color: Colors.blueGrey,
                thickness: 1.0),

            // SizedBox(height: 5),
            Text(
              'Consultation 02',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Your pet has diarrhea and needs diarrhea medicine to cure it. Medicines can be ordered at our place.',
              style: TextStyle(fontSize: 15),
            ),
            Divider(
              height: 23, 
              color: Colors.blueGrey, 
              thickness: 1.0),

            // SizedBox(height: 5),
            Text(
              'Consultation 03',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Your pet has diarrhea and needs diarrhea medicine to cure it. Medicines can be ordered at our place.',
              style: TextStyle(fontSize: 15),
            ),
            Divider(
              height: 23, 
              color: Colors.blueGrey, 
              thickness: 1.0),

            // SizedBox(height: 5),
            Text(
              'Consultation 04',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Your pet has diarrhea and needs diarrhea medicine to cure it. Medicines can be ordered at our place.',
              style: TextStyle(fontSize: 15),
            ),
            Divider(
              height: 23, 
              color: Colors.blueGrey, 
              thickness: 1.0),
          ],
        ),
      ),
    );
  }
}
