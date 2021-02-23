import 'package:flutter/material.dart';
import 'package:todo/utils/styles.dart';

class DeleteTaskWarningDialog extends StatelessWidget {
  const DeleteTaskWarningDialog({this.onDeleteTask});
  final Function onDeleteTask;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete task"),
      content: Text(
        "Once deleted, this task will be gone forever.",
      ),
      actions: [
        TextButton(
          child: Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: TodoColors.darkGrey,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: this.onDeleteTask,
        )
      ],
    );
  }
}
