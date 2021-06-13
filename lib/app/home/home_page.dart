import 'package:fluid/app/auth/auth_service.dart';
import 'package:fluid/app/task/single_task_model_v1.dart';
import 'package:fluid/app/task/task_model_v1.dart';
import 'package:fluid/app/welcome/sign_up/sign_up_page.dart';
import 'package:fluid/app/welcome/welcome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(HomeViewModel());
    final authService = Get.put(AuthService());

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
      body: StreamBuilder<List<TaskModelV1>>(
        stream: viewModel.taskListStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!;
          final docId = data.first.id;
          final taskList = data.first.taskList
              .map((e) => SingleTaskModelV1.fromMap(e))
              .toList();

          return Focus(
            onKey: (FocusNode node, RawKeyEvent event) => true,
            child: RawKeyboardListener(
              autofocus: true,
              focusNode: viewModel.desktopFocusNode,
              onKey: (RawKeyEvent event) async {
                if (event.logicalKey == LogicalKeyboardKey.enter &&
                    event.runtimeType.toString() == 'RawKeyDownEvent') {
                  await viewModel.addTask(docId);
                }
              },
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    final task = taskList[index];
                    return GestureDetector(
                      // onTap: () => showBottomSheet(context, task),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ListTile(
                          tileColor: FluidColor.green,
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(task.title),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              // print(docId);
                              await viewModel.finishTask(task, docId);
                            },
                            icon: Icon(Icons.check),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> showBottomSheet(BuildContext context, TaskModelV1 taskModel) {
    final viewModel = Get.put(HomeViewModel());
    final screenHeight = MediaQuery.of(context).size.height;

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.8,
          color: FluidColor.darkGreen,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: viewModel.taskTitleEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'taskModel.title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!value.contains('@')) {
                        return 'Enter your email address';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // await viewModel.updateTaskTitle(taskModel.id);
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
