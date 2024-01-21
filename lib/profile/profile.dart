import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class User {
  String name;
  String phone;
  String address;
  String email;

  User({
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });
}

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  final User modelUser = User(
    name: "John Doe",
    phone: "123-456-7890",
    address: "123 Main St, Cityville",
    email: "john.doe@example.com",
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ProfileScreen(user: modelUser),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

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
          'PROFILE',
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 15),
            GestureDetector(
              onTap: _pickImage,
              child: Ink.image(
                image: _image == null
                    ? AssetImage('assets/empty.png')
                    : FileImage(_image!) as ImageProvider,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            ItemProfile(
                'Name : ${widget.user.name}', CupertinoIcons.person, () {}),
            SizedBox(height: 8),
            ItemProfile(
                'Phone : ${widget.user.phone}', CupertinoIcons.phone, () {}),
            SizedBox(height: 6),
            ItemProfile('Address : ${widget.user.address}',
                CupertinoIcons.location, () {}),
            SizedBox(height: 6),
            ItemProfile(
                'Email : ${widget.user.email}', CupertinoIcons.mail, () {}),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle logout logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purpleAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget ItemProfile(String title, IconData iconData, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
