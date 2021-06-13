import 'package:get/get.dart';

import '../auth/auth_service.dart';
import '../firebase/cloud_firestore/cloud_firestore_service.dart';
import '../firebase/cloud_firestore/firestore_path.dart';
import 'task_model_v1.dart';

class TaskRemoteDataSource {
  final CloudFirestoreService _cloudFirestoreService =
      Get.put(CloudFirestoreService());
  final AuthService _authService = Get.put(AuthService());

  String get currentUserId => _authService.currentUserId;

  Future<void> finishTask(Map<String, dynamic> data, String taskId) async {
    await _cloudFirestoreService.removeArrayElement(
      path: FirestorePath.taskPath(
        userId: currentUserId,
        taskId: taskId,
      ),
      fieldName: 'taskList',
      data: data,
    );
  }

  Future<void> addTask(Map<String, dynamic> data, String taskId) async {
    await _cloudFirestoreService.updateArrayElement(
      path: FirestorePath.taskPath(
        userId: currentUserId,
        taskId: taskId,
      ),
      fieldName: 'taskList',
      data: data,
    );
  }

  Future<void> setInitialInbox(Map<String, dynamic> data) async {
    await _cloudFirestoreService.setData(
      path: FirestorePath.taskPath(
        userId: currentUserId,
        taskId: data['id'],
      ),
      data: data,
    );
  }

  // Future<void> updateTaskTitle(
  //     {required String taskId, required String taskTitle}) async {
  //   await _cloudFirestoreService.updateData(
  //     path: FirestorePath.taskPath(
  //       userId: _authService.currentUserId,
  //       taskId: taskId,
  //     ),
  //     data: {'title': taskTitle},
  //   );
  // }

  Stream<List<TaskModelV1>> get inboxTaskListStream {
    return _cloudFirestoreService.collectionStream(
      path: FirestorePath.taskDomain(currentUserId),
      queryBuilder: (query) => query.where('taskType', isEqualTo: 'inbox'),
      builder: (data, _) {
        var stream;
        try {
          stream = TaskModelV1.fromMap(data!);
        } catch (e) {
          print(e);
        }
        return stream;
      },
    );
  }
}
