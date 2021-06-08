import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class SingleTaskModelV1 {
  SingleTaskModelV1(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
  );

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;

  SingleTaskModelV1 copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
  }) {
    return SingleTaskModelV1(
      id ?? this.id,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
      title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'title': title,
    };
  }

  factory SingleTaskModelV1.fromMap(Map<String, dynamic> map) {
    return SingleTaskModelV1(
      map['id'],
      map['createdAt'].toDate(),
      map['updatedAt'].toDate(),
      map['title'],
    );
  }
  factory SingleTaskModelV1.initialData() {
    final uuid = Uuid();
    return SingleTaskModelV1(
      uuid.v4(),
      DateTime.now(),
      DateTime.now(),
      '',
    );
  }
}
