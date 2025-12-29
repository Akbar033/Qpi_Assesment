import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/views/corrective%20maiantance/CorrectiveMaintance.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  // 🔹 Small helper inside SAME class
  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value.isEmpty ? '-' : value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Records'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.barcode_reader),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesNames.scanBarCode);
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesNames.addProductScreen);
                },
              ),
              //IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CorrectiveMaintanance()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('maintanance_data')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // 🔹 Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🔹 Error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // 🔹 Empty
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No maintenance data found'));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Maintenance Record',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Divider(),

                      // 🔹 TYPE
                      infoRow('Device Type', data['type']?['deviceType'] ?? ''),
                      infoRow(
                        'Malfunction Type',
                        data['type']?['malfunctiontype'] ?? '',
                      ),
                      infoRow('Type Reason', data['type']?['reason'] ?? ''),

                      const Divider(),

                      // 🔹 MACHINE STATUS
                      infoRow(
                        'Fault Stop Machine',
                        (data['machine status']?['fault stop machine'] ?? false)
                            ? 'Yes'
                            : 'No',
                      ),
                      infoRow(
                        'Stop Reason',
                        data['machine status']?['reason why stop machine'] ??
                            '',
                      ),

                      const Divider(),

                      // 🔹 MALFUNCTION REASON
                      infoRow(
                        'Malfunction Reason',
                        data['malfunction reason']?['reason'] ?? '',
                      ),
                      infoRow(
                        'Malfunction Comment',
                        data['malfunction reason']?['malfunction comment'] ??
                            '',
                      ),

                      const Divider(),

                      // 🔹 FAULT FIXED
                      infoRow(
                        'Fault Fixed',
                        (data['fault fixed']?['is_fault_fixed'] ?? false)
                            ? 'Yes'
                            : 'No',
                      ),
                      infoRow(
                        'Fault Fixed Comment',
                        data['fault fixed']?['fault_fixed_comment'] ?? '',
                      ),

                      const Divider(),

                      // 🔹 SPARE PARTS
                      infoRow(
                        'Spare Parts Used',
                        (data['Spare_parts']?['spare_parts_used'] ?? false)
                            ? 'Yes'
                            : 'No',
                      ),
                      infoRow(
                        'Spare Parts Comment',
                        data['Spare_parts']?['sprareparts_comment'] ?? '',
                      ),

                      const Divider(),

                      // 🔹 START DATE
                      infoRow(
                        'Start Date',
                        data['start_date']?['maintenance_date'] ?? '',
                      ),
                      infoRow(
                        'Start Comment',
                        data['start_date']?['maintenance_comment'] ?? '',
                      ),

                      const Divider(),

                      // 🔹 END DATE
                      infoRow(
                        'End Date',
                        data['end_date']?['maintenance_end_date'] ?? '',
                      ),
                      infoRow(
                        'End Comment',
                        data['end_date']?['end_date_comment'] ?? '',
                      ),

                      const Divider(),

                      // 🔹 DESCRIPTION
                      infoRow(
                        'Report Description',
                        data['Description']?['report_description'] ?? '',
                      ),
                      infoRow(
                        'Complete Description',
                        data['Description']?['Complete Description'] ?? '',
                      ),

                      const Divider(),

                      // 🔹 CREATED AT
                      if (data['created_at'] != null)
                        Text(
                          'Created: ${(data['created_at'] as Timestamp).toDate()}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
