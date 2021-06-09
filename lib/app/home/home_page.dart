import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Get.put(HomeViewModel());

    return Scaffold(
      backgroundColor: FluidColor.baseGrey,
      body: RawKeyboardListener(
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
    );
  }
}
