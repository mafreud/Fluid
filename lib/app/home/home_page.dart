import 'package:fluid/app/home/home_view_model.dart';
import 'package:fluid/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Get.put(HomeViewModel());

    return Scaffold(
      backgroundColor: FluidColor.baseGrey,
      body: Center(
        child: Obx(
          () => Text('${viewModel.count}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          viewModel.increment();
        },
      ),
    );
  }
}
