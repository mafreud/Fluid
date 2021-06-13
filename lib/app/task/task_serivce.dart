import 'package:fluid/app/auth/auth_service.dart';
import 'package:fluid/app/task/single_task_model_v1.dart';
import 'package:fluid/app/task/task_model_v1.dart';
import 'package:fluid/app/task/task_repository.dart';
import 'package:get/get.dart';

class TaskService {
  final TaskRepository _taskRepository = Get.put(TaskRepository());
  final AuthService _authService = Get.put(AuthService());

  // Future<void> createTask(
  //     {required String title, required String subtitle}) async {
  //   final taskModel = TaskModelV1.initialData(title: title, subtitle: subtitle);
  //   await _taskRepository.setTask(taskModel);
  // }

  // Future<void> updateTaskTitle(
  //     {required String taskId, required String taskTitle}) async {
  //   await _taskRepository.updateTaskTitle(taskId: taskId, taskTitle: taskTitle);
  // }

  Future<void> updateTaskOrder(Map<String, dynamic> data, String taskId) async {
    await _taskRepository.updateTaskListArray(data, taskId);
  }

  Future<void> addTask(String taskId) async => await _taskRepository
      .taskArrayUnion(SingleTaskModelV1.initialData(), taskId);

  Future<void> updateTaskTitle(Map<String, dynamic> data, String taskId) async {
    await _taskRepository.updateTaskListArray(data, taskId);
  }

  Future<void> finishTask(SingleTaskModelV1 singleTask, String taskId) async =>
      await _taskRepository.finishTask(singleTask, taskId);

  Future<void> setInitialInbox() async {
    final currentUserId = _authService.currentUserId;
    final initialInboxData = TaskModelV1.initialInboxTask(currentUserId);
    await _taskRepository.setInitialInbox(initialInboxData);
  }

  Stream<List<TaskModelV1>> get taskListStream =>
      _taskRepository.taskListStream;
}
