import 'package:flutter/material.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/screens/modify_task.screen.dart';
import 'package:todo/views/widgets/task_tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    @required this.scrollController,
    @required this.tasks,
    @required this.tasksCount,
    @required this.onCheckTask,
    @required this.onDeleteTask,
    Key key,
  }) : super(key: key);
  final ScrollController scrollController;
  final List<Task> tasks;
  final int tasksCount;
  final Function(Task) onCheckTask;
  final void Function(Task) onDeleteTask;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: this.scrollController,
      itemCount: this.tasksCount,
      itemBuilder: (_, index) {
        var task = this.tasks[index];
        return TaskTile(
          onSelectedAction: (action) {
            if (action == taskTileActions[0])
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModifyTaskScreen(task: task),
                ),
              );
            else
              this.onDeleteTask(task);
          },
          task: task,
          isChecked: task.isDone ?? false,
          position: (index + 1),
          onCheck: (value) {
            task.isDone = value;
            this.onCheckTask(task);
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
