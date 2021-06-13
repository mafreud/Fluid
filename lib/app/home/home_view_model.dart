import 'package:fluid/app/task/single_task_model_v1.dart';
import 'package:fluid/app/task/task_model_v1.dart';
import 'package:fluid/app/task/task_serivce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final TaskService _taskService = Get.put(TaskService());
  final FocusNode desktopFocusNode = FocusNode();

  final taskTitleEditingController = TextEditingController();

  // Future<void> createTask(
  //     {required String title, required String subtitle}) async {
  //   await _taskService.createTask(title: title, subtitle: subtitle);
  // }

  Future<void> finishTask(SingleTaskModelV1 singleTask, String taskId) async =>
      await _taskService.finishTask(singleTask, taskId);

  Future<void> updateTaskOrder(Map<String, dynamic> data, String taskId) async {
    await _taskService.updateTaskOrder(data, taskId);
  }

  Future<void> updateTaskTitle(Map<String, dynamic> data, String taskId) async {
    await _taskService.updateTaskTitle(data, taskId);
    taskTitleEditingController.clear();
  }

  Future<void> addTask(String taskId) async =>
      await _taskService.addTask(taskId);

  Stream<List<TaskModelV1>> get taskListStream => _taskService.taskListStream;
}
