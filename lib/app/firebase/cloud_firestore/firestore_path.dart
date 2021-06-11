class FirestorePath {
  /// usersV1
  static const String userDomain = 'usersV1';

  /// usersV1/:uid/tasks
  static String taskDomain(String userId) => '$userDomain/$userId/tasks';

  /// usersV1/:uid
  static String userPath(String userId) => '$userDomain/$userId';

  /// usersV1/:uid/tasks/:taskId
  static String taskPath({required String userId, required String taskId}) =>
      '$userDomain/$userId/tasks/$taskId';
}
