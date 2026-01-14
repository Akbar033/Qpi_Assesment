import 'package:flutter/material.dart';

class Admintext extends StatelessWidget {
  final String title;
  final TextStyle style;
  const Admintext({super.key, required this.title, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: style);
  }
}
