// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Color clr;
  final String message;
  const ChatBubble({Key? key, required this.message, required this.clr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: clr,
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodySmall,
        ));
  }
}
