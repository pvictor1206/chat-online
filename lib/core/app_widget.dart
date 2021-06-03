import 'package:chat_online/home/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Online',
      debugShowCheckedModeBanner: false,
      home: HomePage(), //Tela principal
    );
  }
}