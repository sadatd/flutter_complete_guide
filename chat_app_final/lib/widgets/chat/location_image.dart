import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/pickers/send_image_picker.dart';
import 'package:flutter_complete_guide/widgets/pickers/user_image_picker.dart';
import 'package:image_picker/image_picker.dart';

/// This is the stateful widget that the main application instantiates.
class LocationImage extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  LocationImage(this.imagePickFn);


  @override
  State<LocationImage> createState() => _LocationImageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _LocationImageState extends State<LocationImage> {
  String dropdownValue = 'image';
  File? _userImageFile;

  void _pickedImage(File image) {
    setState(() {
      _userImageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(20),
      focusColor: Colors.blue,
      dropdownColor: Colors.green.shade200,
      iconDisabledColor: Colors.black,
      icon: Icon(Icons.attach_file),
      iconSize: 24,
      style: TextStyle(fontSize: 1),
      elevation: 0,
      underline: Container(
        height: 8,
      ),
      onChanged: (String? newValue) {
        setState(() {
          // dropdownValue = newValue!;
        });
      },
      items: [
        DropdownMenuItem<String>(
          value: 'image',
          child: SendImagePicker(_pickedImage, true),
        ),
        DropdownMenuItem<String>(
          value: 'location',
          child: IconButton(
            icon: Icon(Icons.pin_drop),
            onPressed: () {
              print("Location selectio....");
            },
          ),
        ),
      ],
    );
  }
}
