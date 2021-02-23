import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todo/core/models/task.dart';

final _todoBox = Hive.box<Task>('todos');

class TodoListNotifier extends ChangeNotifier {
  List<Task> _todos = _todoBox.values.toSet().toList();
  List<Task> get tasks => _todos;
  int get tasksCount => _todos.length;

  void addTask(Task task) {
    _todos = _addTaskToDB(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _todos = _removeFromDB(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    _todos = _updateInDB(task);
    notifyListeners();
  }
}

List<Task> _addTaskToDB(Task task) {
  _todoBox.add(task);
  return _todoBox.values.toSet().toList();
}

List<Task> _removeFromDB(Task task) {
  int index = _todoBox.values.toList().indexWhere((t) => t == task);
  _todoBox.deleteAt(index);
  return _todoBox.values.toSet().toList();
}

List<Task> _updateInDB(Task task) {
  int index = _todoBox.values.toList().indexWhere((t) => t == task);
  _todoBox.putAt(index, task);
  return _todoBox.values.toSet().toList();
}
