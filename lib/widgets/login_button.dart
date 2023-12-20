// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.ontap,
    required this.label,
  }) : super(key: key);
  final void Function()? ontap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.red,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 180),
        //margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
