import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/screens/modify_task.screen.dart';
import 'package:todo/views/widgets/reusables/delete_task_warning.dart';
import 'package:todo/views/widgets/reusables/priority_badge.dart';
import 'package:todo/views/widgets/reusables/square_icon_btn.dart';
import 'package:todo/views/widgets/task_form_input.dart';

class TaskDetailsScreen extends HookWidget {
  final Task task;
  const TaskDetailsScreen({@required this.task});
  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();
    final _tasksProvider = useProvider(tasksChangeNotifier);
    return Scaffold(
      appBar: AppBar(elevation: 4, backgroundColor: TodoColors.accent),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            this.task.imageURL == null || this.task.imageURL.isEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    height: screenWidth(context) / 1.5,
                    constraints: BoxConstraints(maxHeight: 500),
                    color: TodoColors.lightGrey,
                    child: Center(
                      child: Icon(Icons.image, size: 60, color: Colors.grey),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: screenWidth(context) / 1.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(this.task.imageURL)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: PriorityBadge(priority: this.task.priority)),
                  Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SquareIconButton(
                          icon: Icons.create,
                          task: this.task,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ModifyTaskScreen(task: this.task),
                            ),
                          ),
                        ),
                        SquareIconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => DeleteTaskWarningDialog(
                              onDeleteTask: () {
                                //Quit the Dialog
                                Navigator.pop(context);
                                // Delete the task from the local DB
                                _tasksProvider.deleteTask(this.task);
                                // Quit the current screen
                                Navigator.pop(context);
                                //😂😂 Yeah I know there's probably a better way to do this but...
                              },
                            ),
                          ),
                          icon: Icons.close,
                          task: this.task,
                        ),
                        FlatButton(
                          splashColor: TodoColors.darkGrey,
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "DONE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: TodoColors.deepDark,
                            ),
                          ),
                          color: TodoColors.accent,
                          textColor: TodoColors.darkGrey,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: TodoColors.deepDark, width: 2),
                              borderRadius: BorderRadius.circular(4)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                this.task.title,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold, color: TodoColors.primary),
              ),
            ),
            FieldTitle(
                title: "Description",
                paddingLeft: 12,
                paddingRight: 12,
                paddingTop: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Text(this.task.description),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Row(
                children: [
                  Text(
                    "Created ${DateFormat.yMMMd('en_us').format(this.task.createDate)}",
                    style: TextStyle(fontSize: 8),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Modified ${DateFormat.yMMMd('en_us').format(this.task.modifiedDate)}",
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
