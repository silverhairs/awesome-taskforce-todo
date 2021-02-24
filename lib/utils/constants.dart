import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/core/notifiers/todolist_notifier.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

const List<String> taskTileActions = ["Modify", "Delete"];
const List<String> filterOptions = [
  "Low priority",
  "Medium priority",
  "High priority",
  "Not filtered"
];
final tasksChangeNotifier = ChangeNotifierProvider<TodoListNotifier>((ref) {
  return TodoListNotifier();
});
