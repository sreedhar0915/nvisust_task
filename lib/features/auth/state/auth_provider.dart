import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nvisust_task/features/auth/models/product.dart';
import 'package:nvisust_task/features/auth/models/users.dart';
import 'package:nvisust_task/features/auth/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  //image picker
  String? imagepath;
  Uint8List? imagebytes;
  // Fetch all products
  List<Productmodel> productsList = [];
  bool isLoadings = false;
  Future<void> fetchAllProducts() async {
    isLoadings = true;
    notifyListeners();
    try {
      productsList = await AuthServices.getAllProducts();
    } catch (e) {
      debugPrint("Error fetching all products: $e");
    }
    isLoadings = false;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>(); //registration formKey
  final loginFormKey = GlobalKey<FormState>(); //login formKey

  final nameController = TextEditingController(); //registration name textfield
  final emailController =
      TextEditingController(); //registration email textfield
  final passwordController =
      TextEditingController(); //registration password textfield
  final confirmPasswordController =
      TextEditingController(); //registration confirmpassword textfield
  final loginEmailController = TextEditingController(); //login email textfield
  final loginPasswordController =
      TextEditingController(); //login password textfield
  bool ispasswoedvisible = false;

  //registration
  bool isLoading = false;
  User? currentUser;
  Future<void> registerUser() async {
    isLoading = true;
    notifyListeners();
    try {
      currentUser = await AuthServices.register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      await _saveUserToPrefs(currentUser!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //login
  Future<void> loginUser() async {
    isLoading = true;
    notifyListeners();
    try {
      currentUser = await AuthServices.login(
        loginEmailController.text,
        loginPasswordController.text,
      );
      await _saveUserToPrefs(currentUser!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //logout
  Future<void> logoutUser() async {
    currentUser = null;

    // clear all controllers

    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    loginEmailController.clear();
    loginPasswordController.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  // saving using SharedPreferences
  Future<void> _saveUserToPrefs(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", user.name);
    await prefs.setString("email", user.email);
    await prefs.setString("token", user.token);
  }
}
