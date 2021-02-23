import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/core/notifiers/todolist_notifier.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/screens/new_task_screen.dart';
import 'package:todo/views/widgets/search_bar.dart';
import 'package:todo/views/widgets/todo_list.dart';

final tasksChangeNotifier = ChangeNotifierProvider<TodoListNotifier>((ref) {
  return TodoListNotifier();
});

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final _appBarCenterNotifier = useState<Widget>(Container());
    final _searchBarController = useTextEditingController.fromValue(
      TextEditingValue.empty,
    );
    final _tasksProvider = useProvider(tasksChangeNotifier);
    final _isSearchBarToggle = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: _isSearchBarToggle.value
            ? SearchBar(
                searchBarController: _searchBarController,
                hideSearchBar: () => _isSearchBarToggle.value = false,
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
          _isSearchBarToggle.value
              ? Container(width: 2)
              : IconButton(
                  icon: Icon(Icons.search, color: TodoColors.accent, size: 24),
                  onPressed: () => _isSearchBarToggle.value = true,
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
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                              color: TodoColors.deepDark),
                        ),
                      ),
                      Expanded(
                        child: _tasksProvider.tasksCount > 0
                            ? TodoList(
                                scrollController: controller,
                              )
                            : Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "NOTHING HERE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: 12),
                                    Text("Just like your crush's replies"),
                                    SizedBox(height: 18),
                                    FlatButton(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 24,
                                      ),
                                      color: TodoColors.deepDark,
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
                                            builder: (context) =>
                                                NewTaskScreen(),
                                          )),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
              )),
    );
  }
}
