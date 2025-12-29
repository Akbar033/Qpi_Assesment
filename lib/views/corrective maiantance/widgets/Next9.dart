import 'package:flutter/material.dart';

class Next9 extends StatefulWidget {
  final Function(String) onTextSend;
  final Function(String) onTxtfield;
  const Next9({super.key, required this.onTextSend, required this.onTxtfield});

  @override
  State<Next9> createState() => _Next9State();
}

class _Next9State extends State<Next9> {
  TextEditingController descriptionController = TextEditingController();
  String selectedStatus = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: InkWell(
              onTap: widget.onTextSend('Description'),
              child: Text(
                'Description',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Checkbox(
                  value: selectedStatus == 'pending',
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = 'pending';
                    });
                  },
                ),
                const Text('pending'),

                Checkbox(
                  value: selectedStatus == 'processing',
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = 'processing';
                    });
                  },
                ),
                const Text('processing'),

                Checkbox(
                  value: selectedStatus == 'completed',
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = 'completed';
                    });
                  },
                ),
                const Text('completed'),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: TextField(
              onChanged: widget.onTxtfield,
              //controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Completion Description',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
