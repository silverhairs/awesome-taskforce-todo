import 'package:flutter/material.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/utils/styles.dart';

class PriorityBadge extends StatelessWidget {
  const PriorityBadge({
    Key key,
    @required this.priority,
  }) : super(key: key);

  final Priority priority;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 100),
      padding: const EdgeInsets.symmetric(vertical: (4)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: this.priority == Priority.HIGH
            ? TodoColors.deepDark
            : this.priority == Priority.MEDIUM
                ? TodoColors.darkGrey
                : TodoColors.lightGrey,
      ),
      child: Center(
        child: this.priority == Priority.HIGH
            ? Text(
                "High",
                style: TextStyle(color: TodoColors.lightGreen, fontSize: 12),
              )
            : this.priority == Priority.MEDIUM
                ? Text(
                    "Medium",
                    style: TextStyle(color: TodoColors.accent, fontSize: 12),
                  )
                : Text(
                    "Low",
                    style: TextStyle(color: TodoColors.deepDark, fontSize: 12),
                  ),
      ),
    );
  }
}
