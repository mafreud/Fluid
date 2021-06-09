import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  var count = 0.obs;
  increment() => count++;
}
