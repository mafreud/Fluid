import 'package:fluid/app/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:fluid/app/user/user_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.put(FirebaseAuthService());
  final UserService _userService = Get.put(UserService());

  bool hasRegisteredWithAnonymous() => _firebaseAuthService.isAnonymous();

  Future<void> signUpAnonymously() async {
    final currentUserId = await _firebaseAuthService.signUpAnonymously();
    await _userService.setUser(currentUserId);
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuthService.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> register(
      {required String email, required String password}) async {
    await _firebaseAuthService.register(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }

  String get currentUserId => _firebaseAuthService.currentUserId!;
}
