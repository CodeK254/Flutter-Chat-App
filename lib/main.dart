import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const ChatScreen(),
      },
    )
  );
}