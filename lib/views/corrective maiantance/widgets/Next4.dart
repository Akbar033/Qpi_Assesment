import 'package:flutter/material.dart';

class Next4 extends StatefulWidget {
  final Function(String) onReason;
  final Function(String) onComment;
  const Next4({super.key, required this.onReason, required this.onComment});

  @override
  State<Next4> createState() => _Next4State();
}

class _Next4State extends State<Next4> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  // function for

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      width: double.infinity,
      // color: const Color.fromARGB(255, 243, 243, 242),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              "Malfunction Reason",
              style: TextStyle(color: Colors.black, fontSize: 9),
            ),
            SizedBox(width: 20),

            // Checkbox(
            //   value: isSelected,
            //   onChanged: (newValue) {
            //     setState(() {
            //       isSelected = newValue!;
            //     });
            //   },
            // ),
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: widget.onReason,
                decoration: InputDecoration(labelText: 'Reason'),
              ),
            ),

            SizedBox(
              width: 200,
              child: TextField(
                onChanged: widget.onComment,
                decoration: InputDecoration(labelText: 'comment '),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
