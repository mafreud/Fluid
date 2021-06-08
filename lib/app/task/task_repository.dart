import 'package:fluid/app/task/single_task_model_v1.dart';
import 'package:fluid/app/task/task_model_v1.dart';
import 'package:fluid/app/task/task_remote_data_source.dart';
import 'package:get/get.dart';

class TaskRepository {
  final TaskRemoteDataSource _taskRemoteDataSource =
      Get.put(TaskRemoteDataSource());

  Future<void> taskArrayUnion(
          SingleTaskModelV1 taskModel, String taskId) async =>
      await _taskRemoteDataSource.taskArrayUnion(taskModel.toMap(), taskId);

  Future<void> finishTask(SingleTaskModelV1 taskModel, String taskId) async =>
      await _taskRemoteDataSource.finishTask(taskModel.toMap(), taskId);

  // Future<void> updateTaskTitle(
  //     {required String taskId, required String taskTitle}) async {
  //   await _taskRemoteDataSource.updateTaskTitle(
  //       taskId: taskId, taskTitle: taskTitle);
  // }

  Future<void> updateTaskListArray(
      Map<String, dynamic> data, String taskId) async {
    await _taskRemoteDataSource.updateTaskListArray(data, taskId);
  }

  Future<void> setInitialInbox(TaskModelV1 taskModel) async =>
      await _taskRemoteDataSource.setInitialInbox(taskModel.toMap());

  Stream<List<TaskModelV1>> get taskListStream =>
      _taskRemoteDataSource.inboxTaskListStream;
}
