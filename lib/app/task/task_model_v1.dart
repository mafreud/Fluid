import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class TaskModelV1 {
  TaskModelV1(
    this.id,
    this.taskType,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.taskList,
  );

  final String id;

  /// inbox, done etc
  final String taskType;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> taskList;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskType': taskType,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'taskList': taskList,
    };
  }

  factory TaskModelV1.fromMap(Map<String, dynamic> map) {
    return TaskModelV1(
      map['id'],
      map['taskType'],
      map['createdBy'],
      map['createdAt'].toDate(),
      map['updatedAt'].toDate(),
      List<dynamic>.from(map['taskList']),
    );
  }

  factory TaskModelV1.initialInboxTask(String currentUserId) {
    final uuid = Uuid();
    return TaskModelV1(
      uuid.v4(),
      'inbox',
      currentUserId,
      DateTime.now(),
      DateTime.now(),
      [],
    );
  }
}
