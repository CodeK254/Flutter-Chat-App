import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/custom_text.dart';

class MessageDisplay extends StatelessWidget {
  final bool sentByMe;
  final String message;
  const MessageDisplay({super.key, required this.sentByMe, required this.message});

  @override
  Widget build(BuildContext context) {
    Color grey = Colors.grey;
    Color white = Colors.white;
    Color black = Colors.black;
    Color teal = Colors.teal;
    return Align(
      alignment: sentByMe ? Alignment.topRight : Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(8),
              bottomRight: const Radius.circular(8),
              topLeft: sentByMe ? const Radius.circular(8) : const Radius.circular(0),
              topRight: sentByMe ? const Radius.circular(0) : const Radius.circular(8),
            ),
            border: Border.all(width: 1, color: teal),
            color: Colors.transparent,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: CustomText(
              text: message,
              fontSize: 14,
              color: Colors.grey[900],
            ),
          ),
        ),
      ),
    );
  }
}