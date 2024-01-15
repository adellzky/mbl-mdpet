import 'package:flutter/material.dart';
import 'package:pbl_mobile/login/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/wel.png',
              height: 180,
            ),
            Image.asset(
              'assets/welcome.png',
              width: 230,
            ),
            const Text(
              "Take Care of Your Animal",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffBE83B2)),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: const Text(
                "Animal managing app, all types of services your Animal in one place.",
                style: TextStyle(fontSize: 20, color: Color(0xffBE83B2)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 45),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffBE83B2)),
                    minimumSize: MaterialStateProperty.all<Size>(Size(70, 70)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ))),
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
