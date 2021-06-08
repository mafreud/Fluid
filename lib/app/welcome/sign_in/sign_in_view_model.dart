import 'package:fluid/app/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignInViewModel extends GetxController {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  final AuthService _authService = Get.put(AuthService());

  Future<void> signIn() async {
    await _authService.signInWithEmailAndPassword(
      email: emailEditingController.text,
      password: passwordEditingController.text,
    );
  }
}
