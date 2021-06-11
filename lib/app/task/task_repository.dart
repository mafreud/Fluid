import 'package:fluid/app/task/task_model.dart';
import 'package:fluid/app/task/task_remote_data_source.dart';
import 'package:get/get.dart';

class TaskRepository {
  final TaskRemoteDataSource _taskRemoteDataSource =
      Get.put(TaskRemoteDataSource());

  Future<void> deleteTask(String taskId) async =>
      await _taskRemoteDataSource.deleteTask(taskId);

  Future<void> setTask(TaskModel taskModel) async =>
      await _taskRemoteDataSource.setTask(taskModel.toMap());

  Stream<List<TaskModel>> get taskListStream =>
      _taskRemoteDataSource.taskListStream;
}
