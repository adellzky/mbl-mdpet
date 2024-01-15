import 'package:flutter/material.dart';
import 'package:pbl_mobile/model/ApiService.dart';
import 'package:pbl_mobile/model/AuthServices.dart';
import '../register/register.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  bool _isObscure = true;
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 50, bottom: 40),
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
        Image(
          image: AssetImage('assets/login.png'),
        ),
        Padding(padding: EdgeInsets.only(bottom: 20)),
        Text(
          "LOGIN TO YOUR ACCOUNT",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0XFFBE83B2),
          ),
        ),

        Container(
          padding: EdgeInsets.only(top: 30, bottom: 15),
          child: TextField(
            controller: userController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0XFFE1DAF5),
              hintText: "Your Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ),

        // PASSWORD
        Container(
          padding: EdgeInsets.only(bottom: 40),
          child: TextField(
            obscureText: _isObscure,
            controller: passController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0XFFE1DAF5),
              hintText: "Your Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () async {
            bool succes = await AuthServices().login(
                email: userController.text, password: passController.text);

            if (succes) {
              Navigator.pushNamed(context, '/home');
              print('Login sukses');
            } else {
              print('Login gagal');
            }
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: const Color(0XFFBE83B2),
            fixedSize: const Size(280, 50),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
            child: const Text("Don't have an account? Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }
}
