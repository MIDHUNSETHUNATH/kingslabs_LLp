import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kingslabs_task/services/logins.dart';
import 'package:kingslabs_task/ui/homescreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final LoginService _apiManager = LoginService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  

  Future<void> login() async {
    isLoading.value = true;

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'username and password cannot be empty');
      isLoading.value = false;
      return;
    }

    try {
      print("username: ${emailController.text}, Password: ${passwordController.text}");

      final result = await _apiManager.login(
        emailController.text,
        passwordController.text,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', emailController.text);
      await prefs.setString('user_password', passwordController.text);


      print("Login successful: $result");
      Get.snackbar('Login Successful', 'Welcome!');
      Get.to(() =>  HomeScreen());
    } catch (e) {
      print("Login failed: $e");
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}