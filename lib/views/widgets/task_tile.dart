import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/screens/task_details_screen.dart';

import 'reusables/priority_badge.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
    required this.position,
    required this.isChecked,
    required this.onCheck,
    required this.onSelectedAction,
  }) : super(key: key);

  final Task task;
  final int position;
  final bool isChecked;
  final void Function(bool) onCheck;
  final void Function(String) onSelectedAction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: this.isChecked
              ? null
              : () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskDetailsScreen(task: task)),
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
                  onChanged: (value) => this.onCheck(value!),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "$position  ${this.task.title}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
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
                PopupMenuButton<String>(
                  onSelected: this.onSelectedAction,
                  icon: Icon(Icons.more_vert,
                      size: 20, color: TodoColors.deepDark),
                  itemBuilder: (context) => taskTileActions
                      .map((String action) => PopupMenuItem<String>(
                            value: action,
                            child: Text(action),
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
            constraints: BoxConstraints(minHeight: 120),
            color: this.isChecked
                ? Colors.white.withOpacity(.7)
                : Colors.transparent,
          ),
        )
      ],
    );
  }
}
