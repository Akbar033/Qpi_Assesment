import 'package:flutter/material.dart';

class Next6 extends StatefulWidget {
  final Function(String) sparePartsComment;
  final Function(bool) usedOrNot;
  const Next6({
    super.key,
    required this.sparePartsComment,
    required this.usedOrNot,
  });

  @override
  State<Next6> createState() => _Next6State();
}

class _Next6State extends State<Next6> {
  bool isslected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      width: double.infinity,

      child: Row(
        children: [
          //text go here
          Text("sparepart used", style: TextStyle(fontSize: 10)),
          //Check box for=
          SizedBox(width: 15),
          Checkbox(
            value: isslected,
            onChanged: (newValue) {
              setState(() {
                isslected = newValue!;
              });
              widget.usedOrNot(isslected);
            },
          ),
          Text(isslected ? 'yes' : 'no'),
          SizedBox(width: 10),
          SizedBox(
            width: 220,
            child: TextField(
              onChanged: widget.sparePartsComment,
              decoration: InputDecoration(labelText: 'Enter comments'),
            ),
          ),
        ],
      ),
    );
  }
}
