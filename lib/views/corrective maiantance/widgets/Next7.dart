import 'package:flutter/material.dart';

class Next7 extends StatefulWidget {
  final Function(DateTime) selectStartDate;
  final Function(String) onComment;
  const Next7({
    super.key,
    required this.selectStartDate,
    required this.onComment,
  });

  @override
  State<Next7> createState() => _Next7State();
}

class _Next7State extends State<Next7> {
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
      widget.selectStartDate(selectedDate!);
    }
  }

  bool is_slected = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          //text go here
          Text("Maintanance start date", style: TextStyle(fontSize: 10)),

          //Check box for=
          IconButton(
            onPressed: pickDate,
            color: Colors.blueAccent,
            icon: Icon(Icons.date_range),
          ),

          InkWell(
            child: Text(
              selectedDate == null
                  ? 'no seleted'
                  : "Selected Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 220,
            child: TextField(
              onChanged: widget.onComment,
              decoration: InputDecoration(labelText: 'Enter comments'),
            ),
          ),
        ],
      ),
    );
  }
}
