import 'package:flutter/material.dart';

class Next2 extends StatefulWidget {
  final Function(String) onTextChanged;
  final Function(String) onDropDownChange;
  const Next2({
    super.key,
    required this.onTextChanged,
    required this.onDropDownChange,
  });

  @override
  State<Next2> createState() => _Next2State();
}

class _Next2State extends State<Next2> {
  TextEditingController txtFiel = TextEditingController();
  @override
  void initState() {
    super.initState();
    txtFiel.addListener(() {
      widget.onTextChanged(txtFiel.text);
    });
  }

  @override
  void dispose() {
    txtFiel.dispose();
    super.dispose();
  }

  String? isSelected;
  final List<String> items = ['Laptop', 'PC', 'Printer', 'Other'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min, // ✅ VERY IMPORTANT
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Malfunction Type'),

            const SizedBox(width: 10),

            SizedBox(
              width: 220, // ✅ FIXED WIDTH (NO UNBOUNDED ERROR)
              //height: 60,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Device Type',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                value: isSelected,
                items: items.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    isSelected = value;
                  });
                  // widget.onDropDownChange;
                  widget.onDropDownChange(value!);
                },
              ),
            ),
            SizedBox(width: 10),

            SizedBox(
              width: 200, // ✅ REQUIRED
              child: TextField(
                controller: txtFiel,
                decoration: InputDecoration(
                  labelText: 'Reason why stop work',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
