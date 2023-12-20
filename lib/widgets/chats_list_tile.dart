// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  ChatListTile({required this.data, super.key});
  late Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //color: Colors.limeAccent,
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 6),
              const Icon(
                Icons.person_rounded,
                size: 40,
              ),
              const SizedBox(width: 15),
              Text(
                data['email'],
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
