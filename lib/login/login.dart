import 'package:flutter/material.dart';
import 'loginscreen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(35),
        child: LoginWidget(),
      ),
    ));
  }
}