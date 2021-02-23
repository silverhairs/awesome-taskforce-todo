import 'package:flutter/material.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/utils/styles.dart';

class SquareIconButton extends StatelessWidget {
  const SquareIconButton({
    Key key,
    @required this.task,
    @required this.icon,
    this.onPressed,
  }) : super(key: key);

  final Task task;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: TodoColors.lightGrey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(icon: Icon(this.icon), onPressed: this.onPressed),
    );
  }
}
