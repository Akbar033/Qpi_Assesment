import 'package:flutter/material.dart';

class Cusbutton extends StatelessWidget {
  final Color? color;
  final String btnName;
  final VoidCallback? onPressed;

  const Cusbutton({
    super.key,
    this.color,
    required this.btnName,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 20,
      onPressed: () {
        onPressed;
      },
      color: color,
      child: Text(btnName),
    );
  }
}
