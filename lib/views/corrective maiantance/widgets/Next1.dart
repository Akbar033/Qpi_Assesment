import 'package:flutter/material.dart';

class Next1 extends StatelessWidget {
  const Next1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.07,
          width: MediaQuery.sizeOf(context).width * 0.25,
          //color: Colors.white,
          child: Text('Decription'),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.08,
          width: MediaQuery.sizeOf(context).width * 0.65,
          //color: Colors.white,
          child: SizedBox(
            height: 220,
            child: TextField(decoration: InputDecoration(labelText: 'Details')),
          ),
        ),
      ],
    );
  }
}
