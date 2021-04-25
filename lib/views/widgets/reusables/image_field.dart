import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/styles.dart';

class ImageField extends StatelessWidget {
  const ImageField({
    Key? key,
    required ImagePicker picker,
    required ValueNotifier<String?> pathNotifier,
  })   : _picker = picker,
        _pathNotifier = pathNotifier,
        super(key: key);

  final ImagePicker _picker;
  final ValueNotifier<String?> _pathNotifier;

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
                    PickedFile? image = await _picker.getImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      _pathNotifier.value = image.path;
                    }
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
                    if (image != null) {
                      _pathNotifier.value = image.path;
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      child: _pathNotifier.value == null
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
                    image: FileImage(File(_pathNotifier.value!)),
                    fit: BoxFit.cover),
              ),
            ),
    );
  }
}
