class FirestorePath {
  /// usersV1
  static const String userDomain = 'usersV1';

  /// taskListV1/:uid/taskList
  static String taskDomain(String userId) => 'taskListV1/$userId/taskList';

  /// usersV1/:uid
  static String userPath(String userId) => '$userDomain/$userId';

  /// taskListV1/:uid/taskList/:taskId
  static String taskPath({required String userId, required String taskId}) =>
      '${taskDomain(userId)}/$taskId';
}
