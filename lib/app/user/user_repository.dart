import 'package:get/get.dart';
import 'user_model.dart';
import 'user_remote_data_source.dart';

class UserRepository {
  UserRemoteDataSource _userRemoteDataSource = Get.put(UserRemoteDataSource());

  Future<void> setUser({
    required String userId,
    required UserModel data,
  }) async {
    await _userRemoteDataSource.setUser(userId: userId, data: data.toMap());
  }
}
