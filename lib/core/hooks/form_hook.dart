import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo/utils/styles.dart';

Form useForm({
  required List<Widget> children,
  required VoidCallback onSubmit,
  required String submitButtonText,
  required ScrollController scrollController,
}) {
  return use(_Form(
    children: children,
    submit: onSubmit,
    submitButtonText: submitButtonText,
    scrollController: scrollController,
  ));
}

class _Form extends Hook<Form> {
  final List<Widget> children;
  final VoidCallback? submit;
  final String submitButtonText;
  final ScrollController scrollController;

  const _Form({
    required this.children,
    required this.scrollController,
    this.submit,
    this.submitButtonText = "Submit",
  });

  @override
  __FormState createState() => __FormState();
}

class __FormState extends HookState<Form, _Form> {
  final _formKey = GlobalKey<FormState>();
  @override
  Form build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        controller: this.hook.scrollController,
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var field in this.hook.children) field,
            TextButton(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (states) => const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => TodoColors.deepDark,
                  ),
                  shape:
                      MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                    (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  )),
              child: Text(
                this.hook.submitButtonText.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: TodoColors.accent,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  return this.hook.submit!();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
