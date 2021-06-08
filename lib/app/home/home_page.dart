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
  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(HomeViewModel());
    final authService = Get.put(AuthService());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: FluidColor.green,
        onPressed: () => viewModel.addTask(viewModel.taskId.string),
        child: Icon(Icons.add),
      ),
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
          viewModel.setTaskId(docId.obs);

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
                child: ReorderableListView(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  onReorder: (int oldIndex, int newIndex) async {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }

                    final result = taskList.removeAt(oldIndex);

                    taskList.insert(newIndex, result);
                    final rawTaskList = taskList.map((e) => e.toMap()).toList();
                    await viewModel
                        .updateTaskOrder({'taskList': rawTaskList}, docId);
                  },
                  children: <Widget>[
                    for (int index = 0; index < taskList.length; index++)
                      GestureDetector(
                        onTap: () =>
                            showBottomSheet(context, taskList, docId, index),
                        key: Key('$index'),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () async {
                                await viewModel.finishTask(
                                    taskList[index], docId);
                              },
                            ),
                            tileColor: FluidColor.green,
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(taskList[index].title),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> showBottomSheet(
    BuildContext context,
    List<SingleTaskModelV1> singleTaskModelList,
    String taskId,
    int index,
  ) {
    final viewModel = Get.put(HomeViewModel());
    final screenHeight = MediaQuery.of(context).size.height;
    final singleTask = singleTaskModelList[index];

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
                      hintText: singleTask.title,
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
                    var singleTask = singleTaskModelList[index];
                    singleTask = singleTask.copyWith(
                      title: viewModel.taskTitleEditingController.text,
                    );
                    singleTaskModelList[index] = singleTask;
                    final rawTaskList =
                        singleTaskModelList.map((e) => e.toMap()).toList();

                    await viewModel.updateTaskTitle(
                      {'taskList': rawTaskList},
                      taskId,
                    );
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
