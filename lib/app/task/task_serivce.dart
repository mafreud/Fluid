import 'package:fluid/app/task/task_model.dart';
import 'package:fluid/app/task/task_repository.dart';
import 'package:get/get.dart';

class TaskService {
  final TaskRepository _taskRepository = Get.put(TaskRepository());

  Future<void> createTask(
      {required String title, required String subtitle}) async {
    final taskModel = TaskModel.initialData(title: title, subtitle: subtitle);
    await _taskRepository.setTask(taskModel);
  }

  Future<void> finishTask(String taskId) async =>
      await _taskRepository.finishTask(taskId);

  Future<void> updateTaskTitle(
      {required String taskId, required String taskTitle}) async {
    await _taskRepository.updateTaskTitle(taskId: taskId, taskTitle: taskTitle);
  }

  Stream<List<TaskModel>> get taskListStream => _taskRepository.taskListStream;
}
