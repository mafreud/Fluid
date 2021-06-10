import 'package:fluid/app/welcome/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';

import '../../../colors.dart';
import '../../auth/auth_service.dart';
import '../../home/home_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: FluidColor.baseGrey,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '💧',
                  style: TextStyle(fontSize: 80),
                ),
                Text(
                  'Fluid',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: FluidColor.green,
                    ),
                    onPressed: () async {
                      final progress = ProgressHUD.of(context);
                      progress!.show();
                      final AuthService authService = Get.put(AuthService());
                      await authService.signUpAnonymously();
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                      progress.dismiss();
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: FluidColor.green,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
