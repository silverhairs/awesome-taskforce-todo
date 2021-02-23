import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/screens/home.dart';
import 'package:todo/views/widgets/task_tile.dart';

class TodoList extends HookWidget {
  const TodoList({
    @required this.scrollController,
    Key key,
  }) : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final _tasksProvider = useProvider(tasksChangeNotifier);
    return ListView.separated(
      controller: this.scrollController,
      itemCount: _tasksProvider.tasksCount,
      itemBuilder: (_, index) {
        var task = _tasksProvider.tasks[index];
        return TaskTile(
          task: task,
          isChecked: task.isDone ?? false,
          position: (index + 1),
          onCheck: (value) {
            task.isDone = value;
            _tasksProvider.updateTask(task);
          },
        );
      },
      separatorBuilder: (_, idx) => Divider(
        height: 0,
        thickness: 0.25,
        indent: 10,
        endIndent: 16,
        color: TodoColors.deepDark,
      ),
    );
  }
}
