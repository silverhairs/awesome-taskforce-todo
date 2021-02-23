import 'package:flutter/material.dart';
import 'package:todo/utils/styles.dart';

class TaskFormField extends StatelessWidget {
  const TaskFormField(
      {Key key,
      @required this.focusNode,
      @required this.controller,
      @required this.nextFieldFocusNode,
      this.maxLength = 140,
      this.maxLines = 1,
      this.onChanged,
      this.onEditingComplete,
      this.hintText,
      this.contentPadding = const EdgeInsets.all(12)})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController controller;
  final FocusNode nextFieldFocusNode;
  final int maxLines, maxLength;
  final void Function(String) onChanged;
  final VoidCallback onEditingComplete;
  final String hintText;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: this.maxLength,
      focusNode: focusNode,
      onChanged: (value) => this.onChanged(value),
      keyboardType: TextInputType.text,
      controller: controller,
      autocorrect: true,
      validator: (value) {
        if (value.isEmpty) return "This field is required.";
        return null;
      },
      onEditingComplete: () {
        nextFieldFocusNode.requestFocus();
        return this.onEditingComplete;
      },
      maxLines: this.maxLines,
      cursorColor: TodoColors.deepDark,
      decoration: InputDecoration(
          counter: Offstage(),
          contentPadding: this.contentPadding,
          filled: true,
          hintText: this.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: TodoColors.lightGrey,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          )),
    );
  }
}

class FieldTitle extends StatelessWidget {
  final String title;
  final double paddingTop, paddingLeft, paddingRight;
  const FieldTitle({
    @required this.title,
    this.paddingTop = 20,
    Key key,
    this.paddingLeft = 0,
    this.paddingRight = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 8.0,
          top: this.paddingTop,
          left: this.paddingLeft,
          right: this.paddingRight),
      child: Text(this.title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
