class UserModel {
  final DateTime createdAt;
  final String id;
  final DateTime updatedAt;

  UserModel(
    this.createdAt,
    this.id,
    this.updatedAt,
  );

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'id': id,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['createdAt'].toDate(),
      map['id'],
      map['updatedAt'].toDate(),
    );
  }

  factory UserModel.initialData(String userId) {
    return UserModel(
      DateTime.now(),
      userId,
      DateTime.now(),
    );
  }
}
