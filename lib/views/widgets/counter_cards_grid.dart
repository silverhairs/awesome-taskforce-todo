import 'package:flutter/material.dart';
import 'package:todo/core/notifiers/todolist_notifier.dart';
import 'package:todo/utils/styles.dart';

class CounterCardsGrid extends StatelessWidget {
  const CounterCardsGrid({
    Key key,
    @required TodoListNotifier tasksProvider,
  })  : _tasksProvider = tasksProvider,
        super(key: key);

  final TodoListNotifier _tasksProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        primary: false,
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        childAspectRatio: 1.5,
        mainAxisSpacing: 4,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${_tasksProvider.tasksCount}",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: TodoColors.lightGreen,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "Total tasks",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${_tasksProvider.tasks.where((task) => !task.isDone).toList().length}",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: TodoColors.lightGreen,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "Active tasks",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${_tasksProvider.tasks.where((task) => task.isDone).toList().length}",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: TodoColors.lightGreen,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "Tasks done",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      height: 80,
    );
  }
}
