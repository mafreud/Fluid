import 'package:fluid/app/auth/auth_service.dart';
import 'package:fluid/app/welcome/sign_up/sign_up_page.dart';
import 'package:fluid/app/welcome/welcome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Get.put(HomeViewModel());
    final AuthService authService = Get.put(AuthService());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: FluidColor.baseGrey,
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await authService.signOut();
            await Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomePage()));
          },
        ),
        actions: [
          authService.hasRegisteredWithAnonymous()
              ? IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  icon: Icon(Icons.account_circle),
                )
              : SizedBox(),
        ],
      ),
      backgroundColor: FluidColor.baseGrey,
      body: Focus(
        onKey: (FocusNode node, RawKeyEvent event) => true,
        child: RawKeyboardListener(
          autofocus: true,
          focusNode: viewModel.focusNode,
          onKey: (RawKeyEvent event) {
            if (event.logicalKey == LogicalKeyboardKey.enter &&
                event.runtimeType.toString() == "RawKeyDownEvent") {
              viewModel.increment();
            }
          },
          child: Center(
            child: Obx(
              () => ListView.builder(
                itemCount: viewModel.count.value,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: FluidColor.green,
                      title: Text('TODO title'),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
