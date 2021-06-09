import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final FocusNode focusNode = FocusNode();
  var count = 0.obs;

  void increment() => count++;
}
