import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluid/app/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:fluid/app/home/home_page.dart';
import 'package:fluid/app/welcome/welcome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demos',
      home: _AuthFlowWidget(),
    );
  }
}

class _AuthFlowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseAuthService = Get.put(FirebaseAuthService());

    return StreamBuilder<User?>(
      stream: firebaseAuthService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data;
        return _data(context, data);
      },
    );
  }

  Widget _data(BuildContext context, User? user) {
    if (user != null) {
      return HomePage();
    }
    return WelcomePage();
  }
}
