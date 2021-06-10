import 'package:fluid/app/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignUpViewModel extends GetxController {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  AuthService _authService = Get.put(AuthService());

  Future<void> signUp() async {
    await _authService.register(
      email: emailEditingController.text,
      password: passwordEditingController.text,
    );
  }
}
