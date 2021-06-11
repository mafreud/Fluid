import 'package:get/get.dart';

import '../auth/auth_service.dart';
import '../firebase/cloud_firestore/cloud_firestore_service.dart';
import '../firebase/cloud_firestore/firestore_path.dart';
import 'task_model.dart';

class TaskRemoteDataSource {
  final CloudFirestoreService _cloudFirestoreService =
      Get.put(CloudFirestoreService());
  final AuthService _authService = Get.put(AuthService());

  String? get currentUserId => _authService.currentUserId;

  Future<void> finishTask(String taskId) async {
    await _cloudFirestoreService.updateData(
        path: FirestorePath.taskPath(
            userId: _authService.currentUserId, taskId: taskId),
        data: {
          'hasFiniehd': true,
        });
  }

  Future<void> setTask(Map<String, dynamic> data) async {
    await _cloudFirestoreService.setData(
      path: FirestorePath.taskPath(
        userId: _authService.currentUserId,
        taskId: data['id'],
      ),
      data: data,
    );
  }

  Stream<List<TaskModel>> get taskListStream {
    return _cloudFirestoreService.collectionStream(
        path: FirestorePath.taskDomain(_authService.currentUserId),
        queryBuilder: (query) => query.where('hasFinished', isEqualTo: false),
        builder: (data, _) {
          var stream;
          try {
            stream = TaskModel.fromMap(data!);
          } catch (e) {
            print(e);
          }
          return stream;
        });
  }
}
