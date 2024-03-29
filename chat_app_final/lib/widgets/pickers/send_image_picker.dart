import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendImagePicker extends StatefulWidget {
  bool showImage;
  final void Function(File pickedImage) imagePickFn;

  SendImagePicker(this.imagePickFn, this.showImage);

  
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
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt_rounded),
        ),
        if (widget.showImage) 
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage!) : null,
          ),
        ),
      ],
    );
  }
}
