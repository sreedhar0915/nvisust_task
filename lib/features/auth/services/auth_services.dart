import 'dart:convert';
import 'dart:math';

import 'package:nvisust_task/features/auth/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:nvisust_task/features/auth/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    await Future.delayed(const Duration(seconds: 2));

    if (!email.contains("@")) {
      throw Exception("Invalid email address");
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    await prefs.setString("email", email);
    await prefs.setString("password", password);

    final user = User(name: name, email: email, token: _generateToken());

    return user;
  }

  // Login
  static Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API delay

    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString("email");
    final savedPassword = prefs.getString("password");
    final savedName = prefs.getString("name");

    if (savedEmail == null || savedPassword == null) {
      throw Exception("User not registered");
    }

    if (email == savedEmail && password == savedPassword) {
      return User(
        name: savedName ?? "User",
        email: savedEmail,
        token: _generateToken(),
      );
    } else {
      throw Exception("Invalid email or password");
    }
  }

  //generating tokens
  static String _generateToken() {
    return "token_${Random().nextInt(999999)}";
  }
}
