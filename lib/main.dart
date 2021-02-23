import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'core/models/task.dart';
import 'utils/styles.dart';
import 'views/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocsDir.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>('todos');
  runApp(ProviderScope(child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: TodoColors.accent,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: TodoColors.deepDark),
        ),
        primaryColor: TodoColors.primary,
        accentColor: TodoColors.deepDark,
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
