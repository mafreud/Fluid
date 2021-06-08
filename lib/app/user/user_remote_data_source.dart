import 'package:get/get.dart';

import '../firebase/cloud_firestore/cloud_firestore_service.dart';
import '../firebase/cloud_firestore/firestore_path.dart';

class UserRemoteDataSource {
  CloudFirestoreService _cloudFirestoreService =
      Get.put(CloudFirestoreService());

  Future<void> setUser(
      {required String userId, required Map<String, dynamic> data}) async {
    await _cloudFirestoreService.setData(
        path: FirestorePath.userPath(userId), data: data);
  }
}
