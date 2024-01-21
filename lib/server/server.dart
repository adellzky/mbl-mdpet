import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class UserProfileServer {
  static final String baseUrl = 'http://localhost:8000/api/users'; 

  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/profile'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> updatedProfile) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profile'),
      body: json.encode(updatedProfile),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user profile');
    }
  }
}

void main() async {
  final userProfileServer = UserProfileServer();

  // Example: Get User Profile
  try {
    final userProfile = await userProfileServer.getUserProfile();
    print('User Profile: $userProfile');
  } catch (e) {
    print('Error fetching user profile: $e');
  }

  // Example: Update User Profile
  try {
    final updatedProfile = {'name': 'New Name', 'phone': '123456789'};
    await userProfileServer.updateUserProfile(updatedProfile);
    print('User profile updated successfully');
  } catch (e) {
    print('Error updating user profile: $e');
  }
}
