import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_complete_guide/widgets/chat/location_image.dart';
import 'package:flutter_complete_guide/widgets/pickers/send_image_picker.dart';
import 'package:flutter_complete_guide/widgets/pickers/user_image_picker.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    setState(() {
      _userImageFile = image;
    });
  }

  bool _isGoogle() {
    return FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
        'google.com';
  }

  // void _sendMessage() async {
  //   FocusScope.of(context).unfocus();
  //   final user = FirebaseAuth.instance.currentUser!;
  //   if (_isGoogle()) {
  //     FirebaseFirestore.instance.collection('chat').add({
  //       'photo_message_url': '',
  //       'text': _enteredMessage,
  //       'createdAt': Timestamp.now(),
  //       'userId': user.uid,
  //       'username': user.displayName,
  //       'userImage': user.photoURL,
  //     });
  //   } else {
  //     // Other users, for now only email-password available
  //     final userData = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .get();
  //     FirebaseFirestore.instance.collection('chat').add({
  //       'photo_message_url': '',
  //       'text': _enteredMessage,
  //       'createdAt': Timestamp.now(),
  //       'userId': user.uid,
  //       'username': userData['username'],
  //       'userImage': userData['image_url']
  //     });
  //   }
  //   _controller.clear();
  // }

  void _send() async {
    final user = FirebaseAuth.instance.currentUser!;
    String photoMessageUrl = '';

    if (_userImageFile != null) { // if we
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_message_images')
          .child(DateTime.now().toString() + '.jpg');

      await ref.putFile(_userImageFile!);

      photoMessageUrl = await ref.getDownloadURL();
    }
    // =====================================
    if (_isGoogle()) {
      FirebaseFirestore.instance.collection('chat').add({
        'photo_message_url': photoMessageUrl.isEmpty ? '' : photoMessageUrl,
        'text': _enteredMessage.isEmpty ? '' : _enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': user.displayName,
        'userImage': user.photoURL,
      });
    } else {
      // Other users, for now only email-password available
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      FirebaseFirestore.instance.collection('chat').add({
        'photo_message_url': photoMessageUrl.isEmpty ? '' : photoMessageUrl,
        'text': _enteredMessage.isEmpty ? '' : _enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData['username'],
        'userImage': userData['image_url']
      });
    }
    setState(() {
      _enteredMessage = '';
    });
    _controller.clear();
    _userImageFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          // LocationImage(_pickedImage),
          SendImagePicker(_pickedImage),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty && _userImageFile == null
                ? null
                : _send,
          ),
        ],
      ),
    );
  }
}
