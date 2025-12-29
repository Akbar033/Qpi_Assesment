import 'package:flutter/material.dart';

class Next8 extends StatefulWidget {
  final Function(DateTime) endDate;
  final Function(String) onComment;
  const Next8({super.key, required this.endDate, required this.onComment});

  @override
  State<Next8> createState() => _Next8State();
}

class _Next8State extends State<Next8> {
  DateTime? selectedDate;
  Future<void> pickDate() async {
    DateTime? pickdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(3000),
    );
    if (pickdate != null) {
      setState(() {
        selectedDate = pickdate;
      });
      widget.endDate(selectedDate!);
    }
  }

  bool is_slected = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Expanded(
        child: Row(
          children: [
            //text go here
            Text("Maintanance end date", style: TextStyle(fontSize: 10)),

            //Check box for=
            IconButton(
              onPressed: pickDate,
              icon: Icon(Icons.date_range, color: Colors.blueAccent),
            ),

            Text(
              selectedDate == null
                  ? 'no seleted'
                  : "Selected Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: widget.onComment,
                decoration: InputDecoration(labelText: 'Enter comments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
