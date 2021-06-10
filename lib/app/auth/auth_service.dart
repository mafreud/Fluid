import 'package:fluid/app/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  FirebaseAuthService _firebaseAuthService = Get.put(FirebaseAuthService());

  Future<void> signUpAnonymously() async {
    final currentUserId = await _firebaseAuthService.signUpAnonymously();

    // TODO ユーザーデータを書き込むように変更
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _firebaseAuthService.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> register(
      {required String email, required String password}) async {
    await _firebaseAuthService.register(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }

  bool hasRegisteredWithAnonymous() => _firebaseAuthService.isAnonymous();
}
