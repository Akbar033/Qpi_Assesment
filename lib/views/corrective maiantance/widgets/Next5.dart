import 'package:flutter/material.dart';

class Next5 extends StatefulWidget {
  final Function(String) onComment;
  final Function(bool) isFixed;
  const Next5({super.key, required this.onComment, required this.isFixed});

  @override
  State<Next5> createState() => _Next5State();
}

class _Next5State extends State<Next5> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // ✅ fixed height (safer than percentage)
      width: double.infinity,
      //color: const Color.fromARGB(255, 243, 243, 242),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Is the fault fixed"),

            const SizedBox(width: 10),

            Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value!; // ✅ null safe
                });
                widget.isFixed(isSelected);
              },
            ),

            Text(isSelected ? 'Yes' : 'No'),

            const SizedBox(width: 10),

            /// ✅ TextField must get bounded width in Row
            SizedBox(
              width: 220, // ✅ fixed width = no unbounded error
              child: TextField(
                onChanged: widget.onComment,
                decoration: const InputDecoration(
                  labelText: 'Enter comments',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
