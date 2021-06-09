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
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            print('enter was pressed');
          }
          viewModel.increment();
        },
        child: Center(child: Obx(() => Text("Clicks: ${viewModel.count}"))),
      ),
    );
  }
}
