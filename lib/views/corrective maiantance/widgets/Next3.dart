import 'package:flutter/material.dart';

class Next3 extends StatefulWidget {
  final Function(bool) onYesNoChanged;
  final Function(String) onReasonChanged;

  const Next3({
    super.key,
    required this.onYesNoChanged,
    required this.onReasonChanged,
  });

  @override
  State<Next3> createState() => _Next3State();
}

class _Next3State extends State<Next3> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      width: double.infinity,
      child: Row(
        children: [
          const Text(
            'Fault stop machine',
            style: TextStyle(color: Colors.black, fontSize: 9),
          ),

          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });

              widget.onYesNoChanged(isChecked); // ✅ SAFE
            },
          ),

          Text(isChecked ? 'Yes' : 'No'),

          SizedBox(
            width: 200,
            child: TextField(
              onChanged: widget.onReasonChanged, // ✅ SAFE
              decoration: const InputDecoration(labelText: 'Enter reason'),
            ),
          ),
        ],
      ),
    );
  }
}
