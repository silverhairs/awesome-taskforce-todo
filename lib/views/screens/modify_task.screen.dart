import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/hooks/form_hook.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/styles.dart';
import 'package:todo/views/widgets/reusables/image_field.dart';
import 'package:todo/views/widgets/task_form_input.dart';

class ModifyTaskScreen extends HookWidget {
  final Task task;
  final _picker = ImagePicker();
  ModifyTaskScreen({required this.task});
  @override
  Widget build(BuildContext context) {
    final _priorityFocusNode = useFocusNode();
    final _scrollController = useScrollController();
    final _priorityNotifier = useState<Priority>(task.priority);
    final _titleController = useTextEditingController(
      text: task.title,
    );
    final _descController = useTextEditingController(
      text: task.description,
    );
    final _titleFocusNode = useFocusNode();
    final _descFocusNode = useFocusNode();
    final _imagePathNotifier = useState<String?>((task.imageURL ?? ''));
    final _tasksProvider = useProvider(tasksChangeNotifier);
    final _editTaskForm = useForm(
        scrollController: _scrollController,
        submitButtonText: "Save",
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16),
            child: Text(
              "Modify task",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: TodoColors.deepDark,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          FieldTitle(title: "Add image", paddingTop: 0),
          ImageField(picker: _picker, pathNotifier: _imagePathNotifier),
          FieldTitle(title: "Title", paddingTop: 24),
          TaskFormField(
            focusNode: _titleFocusNode,
            controller: _titleController,
            nextFieldFocusNode: _descFocusNode,
            hintText: "Task title (140 characters)",
            maxLength: 140,
          ),
          FieldTitle(title: "Description"),
          TaskFormField(
            focusNode: _descFocusNode,
            controller: _descController,
            nextFieldFocusNode: _priorityFocusNode,
            hintText: "240 Characters",
            maxLength: 240,
            maxLines: 4,
          ),
          FieldTitle(title: "Priority"),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: TodoColors.lightGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Priority>(
                focusColor: Colors.transparent,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                focusNode: _priorityFocusNode,
                value: _priorityNotifier.value,
                onChanged: (value) => _priorityNotifier.value = value!,
                items: Priority.values.map((priority) {
                  String displayed;
                  if (priority == Priority.HIGH)
                    displayed = "HIGH";
                  else if (priority == Priority.MEDIUM)
                    displayed = "MEDIUM";
                  else
                    displayed = "LOW";
                  return DropdownMenuItem(
                    child: Text(
                      displayed,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: priority,
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
        onSubmit: () {
          task.title = _titleController.text;
          task.description = _descController.text;
          task.imageURL = _imagePathNotifier.value!;
          task.priority = _priorityNotifier.value;
          task.modifiedDate = DateTime.now();
          _tasksProvider.updateTask(task);
          return Navigator.pop(context);
        });
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: TodoColors.accent,
      ),
      body: _editTaskForm,
    );
  }
}
