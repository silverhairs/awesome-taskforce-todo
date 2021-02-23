import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/screens/task_details_screen.dart';

import 'reusables/priority_badge.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key key,
    @required this.task,
    @required this.position,
    @required this.isChecked,
    @required this.onCheck,
  }) : super(key: key);

  final Task task;
  final int position;
  final bool isChecked;
  final void Function(bool) onCheck;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskDetailsScreen(task: task)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        constraints: BoxConstraints(minHeight: 120),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.padded,
              value: this.isChecked,
              onChanged: (value) => this.onCheck(value),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "$position  ${this.task.title}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  PriorityBadge(priority: this.task.priority),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            "Created ${DateFormat.yMMMd('en_US').format(this.task.createDate)}",
                            style: TextStyle(fontSize: 8)),
                      ),
                      Expanded(
                        child: Text(
                            "Modified ${DateFormat.yMMMd('en_US').format(this.task.modifiedDate)}",
                            style: TextStyle(fontSize: 8)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert, size: 20, color: TodoColors.deepDark),
              onPressed: () => print("//TODO: More"),
            )
          ],
        ),
      ),
    );
  }
}
