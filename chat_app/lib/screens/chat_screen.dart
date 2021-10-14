import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('Works'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chats/HY2gzVyoxyT54pKIxvXT/messages')
              .snapshots()
              .listen((data) {
            data.documents.forEach((element) {
              print(element['text']);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
