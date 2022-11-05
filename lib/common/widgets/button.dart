import 'package:dos/common/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTab;
  const MyButton({super.key, required this.label, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
          width: 120,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryClr,
          ),
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
