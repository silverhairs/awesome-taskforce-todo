import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/core/notifiers/todolist_notifier.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/screens/new_task_screen.dart';
import 'package:todo/views/widgets/categories_cards_grid.dart';
import 'package:todo/views/widgets/empty_todo_list_msg.dart';
import 'package:todo/views/widgets/reusables/delete_task_warning.dart';
import 'package:todo/views/widgets/search_bar.dart';
import 'package:todo/views/widgets/todo_list.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _searchBarController = useTextEditingController.fromValue(
      TextEditingValue.empty,
    );
    final _tasksProvider = useProvider<TodoListNotifier>(tasksChangeNotifier);
    final _isSearchBarVisible = useState<bool>(false);
    final _tasksFoundState = useState<List<Task>>(_tasksProvider.tasks);

    void _searchTask(value) {
      _tasksFoundState.value = _tasksProvider.tasks
          .where(
            (task) => (task.title.toLowerCase()).contains(value.toLowerCase()),
          )
          .toList();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _isSearchBarVisible.value
              ? SearchBar(
                  searchBarController: _searchBarController,
                  hideSearchBar: () => _isSearchBarVisible.value = false,
                  onChanged: (value) => _searchTask(value),
                )
              : Container(),
          centerTitle: true,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'assets/images/logo-light.png',
              height: 24,
              width: 24,
            ),
          ),
          actions: [
            _isSearchBarVisible.value
                ? Container(width: 2)
                : IconButton(
                    icon:
                        Icon(Icons.search, color: TodoColors.accent, size: 24),
                    onPressed: () => _isSearchBarVisible.value = true,
                  ),
            IconButton(
              icon: Icon(Icons.filter_list, color: TodoColors.accent, size: 24),
              onPressed: () => print("//TODO: Filter dropdown"),
            )
          ],
        ),
        body: SizedBox.expand(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: Container(color: TodoColors.primary)),
                  Expanded(
                    child: Container(color: TodoColors.lightGrey),
                    flex: 2,
                  )
                ],
              ),
              DraggableScrollableSheet(
                minChildSize: 0.97,
                maxChildSize: 0.97,
                initialChildSize: 0.97,
                builder: (context, controller) => Card(
                  elevation: 5,
                  color: TodoColors.accent,
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            "Welcome",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: TodoColors.deepDark),
                          ),
                        ),
                        CategoriesCardsGrid(tasksProvider: _tasksProvider),
                        Expanded(
                          child: _tasksProvider.tasksCount > 0
                              ? TodoList(
                                  tasks: _isSearchBarVisible.value
                                      ? _tasksFoundState.value
                                      : _tasksProvider.tasks,
                                  tasksCount: _isSearchBarVisible.value
                                      ? _tasksFoundState.value.length
                                      : _tasksProvider.tasksCount,
                                  onCheckTask: _tasksProvider.updateTask,
                                  scrollController: controller,
                                  onDeleteTask: (task) => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DeleteTaskWarningDialog(
                                      onDeleteTask: () {
                                        _tasksProvider.deleteTask(task);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                )
                              : EmptyTodoListMessage(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add a new task",
          child: Icon(Icons.add, color: TodoColors.accent),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTaskScreen()),
          ),
        ),
      ),
    );
  }
}
