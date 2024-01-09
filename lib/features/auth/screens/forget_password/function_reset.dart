import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void processPasswordReset(String email, String newPassword) async {
  final String functionUrl = "https://pisit-db790.firebaseapp.com/__/auth/action?mode=resetPassword&oobCode=IhWVI5dYXIfBsSgx_kIoQ5lGX6d421aI3ClGw6aU7PAAAAGMoY860w&apiKey=AIzaSyB60t8UZ9FCRozMJ8cvpL7Zgc0uNbBknQk&lang=en";

  final Map<String, dynamic> requestData = {
    'email': email,
    'newPassword': newPassword,
  };

  try {
    final http.Response response = await http.post(
      Uri.parse(functionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    final Map<String, dynamic> result = jsonDecode(response.body);

    if (result['success'] == true) {
      print("Password changed successfully");
    } else {
      print("Error changing password");
    }
  } catch (e) {
    print("Error changing password: $e");
  }
}