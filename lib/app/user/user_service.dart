import 'package:get/get.dart';
import 'user_model.dart';
import 'user_repository.dart';

class UserService {
  UserRepository _userRepository = Get.put(UserRepository());

  /// ユーザーデータをFirestoreに保存
  Future<void> setUser(String userId) async {
    final data = UserModel.initialData(userId);
    await _userRepository.setUser(userId: userId, data: data);
  }
}
