// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
      {super.key,
      required this.hintText,
      required this.obsc,
      this.onChanged,
      this.controller});
  final String hintText;
  void Function(String)? onChanged;
  final bool obsc;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obsc,
        cursorHeight: 15,
        style: Theme.of(context).textTheme.headlineSmall!,
        decoration: InputDecoration(
          hintText: (hintText),
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
