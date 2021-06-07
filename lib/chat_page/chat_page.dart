import 'package:chat_online/chat_page/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  void _sendMessage(String text){
    FirebaseFirestore.instance.collection("mensagens").add({
      'text' : text
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Online"),
        elevation: 0,
        centerTitle: true,
      ),
      body: TextComposer(_sendMessage),
    );
  }
}
