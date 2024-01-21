import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl_mobile/login/login.dart';
import 'package:pbl_mobile/model/AuthServices.dart';
import 'package:pbl_mobile/home.dart';

void main() {
  runApp(const DisplayProfile());
}

class DisplayProfile extends StatelessWidget {
  const DisplayProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      home: const ProfileScreen(),
    );
  }
}

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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  late User user;

  @override
  void initState() {
    super.initState();
    user = User(
      name: "John Doe",
      phone: "123-456-7890",
      address: "123 Main St",
      email: "john.doe@example.com",
    );
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
          'PROFILE',
          style: TextStyle(
            color: Colors.purpleAccent,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 0.15)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              GestureDetector(
                onTap: _pickImage,
                child: Ink.image(
                  image: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/empty.png') as ImageProvider,
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
              const SizedBox(height: 25),
              editableItemProfile(
                'Name :',
                user.name,
                CupertinoIcons.person,
                () => _navigateToEditScreen(context, 'Name'),
              ),
              const SizedBox(height: 8),
              editableItemProfile(
                'Phone :',
                user.phone,
                CupertinoIcons.phone,
                () => _navigateToEditScreen(context, 'Phone'),
              ),
              const SizedBox(height: 6),
              editableItemProfile(
                'Address :',
                user.address,
                CupertinoIcons.location,
                () => _navigateToEditScreen(context, 'Address'),
              ),
              const SizedBox(height: 6),
              editableItemProfile(
                'Email :',
                user.email,
                CupertinoIcons.mail,
                () => _navigateToEditScreen(context, 'Email'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Auth auth = Auth();
                  bool success = await auth.logout();

                  if (success) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Logout failed. Please try again.')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editableItemProfile(
      String title, String subtitle, IconData iconData, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ],
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconData),
          trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
          tileColor: Colors.white,
        ),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context, String field) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          field: field,
          initialValue: _getUserFieldValue(field),
          onFieldSaved: (newValue) => _updateUserField(field, newValue),
        ),
      ),
    );
  }

  String _getUserFieldValue(String field) {
    switch (field) {
      case 'Name':
        return user.name;
      case 'Phone':
        return user.phone;
      case 'Address':
        return user.address;
      case 'Email':
        return user.email;
      default:
        return '';
    }
  }

  void _updateUserField(String field, String newValue) {
    setState(() {
      switch (field) {
        case 'Name':
          user.name = newValue;
          break;
        case 'Phone':
          user.phone = newValue;
          break;
        case 'Address':
          user.address = newValue;
          break;
        case 'Email':
          user.email = newValue;
          break;
      }
    });
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

class EditProfileScreen extends StatelessWidget {
  final String field;
  final String initialValue;
  final ValueChanged<String> onFieldSaved;

  const EditProfileScreen({
    Key? key,
    required this.field,
    required this.initialValue,
    required this.onFieldSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit $field'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Enter new $field:'),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: initialValue,
              onChanged: (value) {
                // Add logic to handle user input (if needed)
              },
              // Add appropriate logic for handling user input
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to save the edited data
                onFieldSaved(initialValue); // Pass the edited value back
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
