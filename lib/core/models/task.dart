import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime createDate;
  @HiveField(3)
  DateTime modifiedDate;
  @HiveField(4)
  Priority priority;
  @HiveField(5)
  String imageURL;
  @HiveField(6)
  bool isDone;

  Task({
    @required this.title,
    @required this.description,
    @required this.createDate,
    @required this.modifiedDate,
    @required this.priority,
    this.isDone = false,
    this.imageURL,
  });
  Map<String, dynamic> toMap() => {
        'title': this.title,
        'description': this.description,
        'create-date': Timestamp.fromDate(this.createDate),
        'modified-date': Timestamp.fromDate(this.modifiedDate),
        'priority': this.priority.toString(),
        'image-url': this.imageURL,
        'is-done': this.isDone,
      };
  static Task fromMap(Map<String, dynamic> data) => Task(
        title: data['title'],
        description: data['description'],
        createDate: data['create-date'].toDate(),
        modifiedDate: data['modified-date'].toDate(),
        imageURL: data['image-url'],
        isDone: data['is-done'],
        priority: data['priority'].Priority.values.firstWhere(
              (t) => t.toString() == 'Priority.' + data['priority'],
            ),
      );
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  LOW,
  @HiveField(1)
  MEDIUM,
  @HiveField(2)
  HIGH,
}
