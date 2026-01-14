import 'package:flutter/material.dart';

class TitleAndData extends StatelessWidget {
  final String tittle;
  final String data;
  const TitleAndData({super.key, required this.tittle, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30, left: 30, top: 2, bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(tittle), Text(data)],
      ),
    );
  }
}
