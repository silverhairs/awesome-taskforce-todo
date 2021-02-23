import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/hooks/form_hook.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/styles.dart';
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

class ImageField extends StatelessWidget {
  const ImageField({
    Key key,
    @required ImagePicker picker,
    @required ValueNotifier<File> imageNotifier,
  })  : _picker = picker,
        _imageNotifier = imageNotifier,
        super(key: key);

  final ImagePicker _picker;
  final ValueNotifier<File> _imageNotifier;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )),
        backgroundColor: TodoColors.accent,
        barrierColor: Colors.blueGrey.withOpacity(1 / 5),
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 30),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: TodoColors.lightGrey),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: TodoColors.deepDark,
                    size: 30,
                  ),
                  onPressed: () async {
                    final image = await _picker.getImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) _imageNotifier.value = File(image.path);
                  },
                ),
              ),
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: TodoColors.lightGrey),
                child: IconButton(
                  icon: Icon(
                    Icons.image,
                    color: TodoColors.deepDark,
                    size: 30,
                  ),
                  onPressed: () async {
                    final image = await _picker.getImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) _imageNotifier.value = File(image.path);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      child: _imageNotifier.value == null
          ? Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: TodoColors.lightGrey,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  "Tap to add an image",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          : Container(
              height: screenWidth(context) / 1.5,
              constraints: BoxConstraints(maxHeight: 500),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(_imageNotifier.value), fit: BoxFit.cover),
              ),
            ),
    );
  }
}
