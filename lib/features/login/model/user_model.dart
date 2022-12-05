import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;
  final String phoneNumber;

  User({required this.name, required this.email, required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number']);

  static Future<User> login(String email, String password) async {
    final body = {'email': email, 'password': password};
    final response = await http.post(
        Uri.parse('https://demo.treblle.com/api/v1/auth/login'),
        body: body);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final user = User.fromJson(json['user']);
      return user;
    } else {
      return User(name: '', email: '', phoneNumber: '');
    }
  }
}
