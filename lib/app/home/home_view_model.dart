import 'package:fluid/app/task/task_model.dart';
import 'package:fluid/app/task/task_serivce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final TaskService _taskService = Get.put(TaskService());
  final FocusNode desktopFocusNode = FocusNode();

  final taskTitleEditingController = TextEditingController();

  Future<void> createTask(
      {required String title, required String subtitle}) async {
    await _taskService.createTask(title: title, subtitle: subtitle);
  }

  Future<void> finishTask(String taskId) async =>
      await _taskService.finishTask(taskId);

  Future<void> updateTaskTitle(String taskId) async {
    await _taskService.updateTaskTitle(
      taskId: taskId,
      taskTitle: taskTitleEditingController.text,
    );
    taskTitleEditingController.clear();
  }

  Stream<List<TaskModel>> get taskListStream => _taskService.taskListStream;
}
