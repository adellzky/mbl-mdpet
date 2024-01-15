import 'package:flutter/material.dart';
import 'registerscreen.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(35),
        child: const RegisterWidget(),
      ),
    ));
  }
}