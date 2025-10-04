import 'dart:convert';
import 'dart:math';

import 'package:nvisust_task/features/auth/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:nvisust_task/features/auth/models/users.dart';

class AuthServices {
  static const String baseUrl = "https://fakestoreapi.com";

  // fetching all products
  static Future<List<Productmodel>> getAllProducts() async {
    final url = Uri.parse("$baseUrl/products");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Productmodel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  //registration
  static Future<User> register(
    String name,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API delay
    if (email.contains("@")) {
      return User(name: name, email: email, token: _generateToken());
    } else {
      throw Exception("Invalid email address");
    }
  }

  //login
  static Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API delay
    if (email == "test@example.com" && password == "1234") {
      return User(name: "Test User", email: email, token: _generateToken());
    } else {
      throw Exception("Invalid credentials");
    }
  }

  //generating tokens
  static String _generateToken() {
    return "token_${Random().nextInt(999999)}";
  }
}
