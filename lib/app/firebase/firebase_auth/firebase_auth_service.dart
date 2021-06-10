import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isAnonymous() {
    final isAnonymous = _firebaseAuth.currentUser!.isAnonymous;
    return isAnonymous;
  }

  Future<void> setDisplayName(displayName) async {
    await _firebaseAuth.currentUser!.updateDisplayName(displayName);
  }

  Future<void> signOut() async => await _firebaseAuth.signOut();

  Future<String> signUpAnonymously() async {
    var data = await _firebaseAuth.signInAnonymously();
    return data.user!.uid;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    _firebaseAuth.currentUser!.linkWithCredential(credential);
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String? get currentUserId => _firebaseAuth.currentUser?.uid;
}
