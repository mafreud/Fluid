import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../colors.dart';
import '../../auth/auth_service.dart';
import '../../home/home_page.dart';
import '../../task/task_serivce.dart';
import '../sign_in/sign_in_page.dart';

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
                      final authService = Get.put(AuthService());
                      final taskService = Get.put(TaskService());

                      await authService.signUpAnonymously();
                      await taskService.setInitialInbox();

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
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _launchURL(
                        'https://www.notion.so/Terms-of-conditions-d119d803139e4fb1b37f2639fc4f1bac');
                  },
                  child: const Text(
                    'By Tapping Get Started \nyou are agreeing to the Terms and Conditions.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
