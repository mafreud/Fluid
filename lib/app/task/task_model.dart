import 'package:uuid/uuid.dart';

class TaskModel {
  TaskModel(
    this.id,
    this.title,
    this.subtitle,
    this.hasFinished,
    this.createdAt,
    this.updatedAt,
  );

  final String id;
  final String title;
  final String subtitle;
  final bool hasFinished;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    bool? hasFinished,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id ?? this.id,
      title ?? this.title,
      subtitle ?? this.subtitle,
      hasFinished ?? this.hasFinished,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'hasFinished': hasFinished,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      map['id'],
      map['title'],
      map['subtitle'],
      map['hasFinished'],
      map['createdAt'].toDate(),
      map['updatedAt'].toDate(),
    );
  }

  factory TaskModel.initialData(
      {required String title, required String subtitle}) {
    final uuid = Uuid();

    return TaskModel(
      uuid.v4(),
      title,
      subtitle,
      false,
      DateTime.now(),
      DateTime.now(),
    );
  }
}
