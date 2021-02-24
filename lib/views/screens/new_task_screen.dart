import 'dart:io';

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

class NewTaskScreen extends HookWidget {
  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final _priorityNotifier = useState<Priority>(Priority.LOW);
    final _titleFocusNode = useFocusNode();
    final _descFocusNode = useFocusNode();
    final _priorityFocusNode = useFocusNode();
    final _scrollController = useScrollController();
    final _titleFieldController = useTextEditingController.fromValue(
      TextEditingValue.empty,
    );
    final _descFieldController = useTextEditingController.fromValue(
      TextEditingValue.empty,
    );
    final _imageNotifier = useState<File>();
    final _tasksProvider = useProvider(tasksChangeNotifier);
    final _form = useForm(
      scrollController: _scrollController,
      submitButtonText: "Create Task",
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16),
          child: Text(
            "New task",
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: TodoColors.deepDark,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        FieldTitle(title: "Add image", paddingTop: 0),
        ImageField(picker: _picker, imageNotifier: _imageNotifier),
        FieldTitle(title: "Title", paddingTop: 24),
        TaskFormField(
          focusNode: _titleFocusNode,
          controller: _titleFieldController,
          nextFieldFocusNode: _descFocusNode,
          hintText: "Task title (140 characters)",
          maxLength: 140,
        ),
        FieldTitle(title: "Description"),
        TaskFormField(
          focusNode: _descFocusNode,
          controller: _descFieldController,
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
            child: DropdownButton(
              focusColor: Colors.transparent,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              focusNode: _priorityFocusNode,
              value: _priorityNotifier.value,
              onChanged: (value) => _priorityNotifier.value = value,
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
        SizedBox(height: 30)
      ],
      onSubmit: () {
        _tasksProvider.addTask(
          Task(
            title: _titleFieldController.text,
            description: _descFieldController.text,
            priority: _priorityNotifier.value,
            imageURL: _imageNotifier.value.path,
            createDate: DateTime.now(),
            modifiedDate: DateTime.now(),
          ),
        );
        return Navigator.pop(context);
      },
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: TodoColors.accent,
      ),
      body: _form,
    );
  }
}
