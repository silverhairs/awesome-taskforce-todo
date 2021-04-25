import 'package:flutter/material.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/screens/new_task_screen.dart';

class EmptyTodoListMessage extends StatelessWidget {
  const EmptyTodoListMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "NOTHING HERE",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12),
          Text("Just like your crush's replies"),
          SizedBox(height: 18),
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                  (states) => const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => TodoColors.deepDark),
                shape:
                    MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                )),
            child: Text(
              "START WITH A NEW TASK",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TodoColors.accent,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewTaskScreen(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
