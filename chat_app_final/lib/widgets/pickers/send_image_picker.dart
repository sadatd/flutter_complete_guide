import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendImagePicker extends StatefulWidget {
  SendImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;
  
  @override
  _SendImagePickerState createState() => _SendImagePickerState();
}

class _SendImagePickerState extends State<SendImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
    widget.imagePickFn(File(pickedImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IconButton(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
        ),
      ],
    );
  }
}
