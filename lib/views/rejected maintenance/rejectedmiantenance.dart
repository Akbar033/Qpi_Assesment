import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/Utils/reusble%20widgets/textWidget.dart';
import 'package:qpi_eng/viewmodel/Corr%20History%20VM/RejectedMaintenance/RejecVm.dart';

class Rejectedmiantenance extends StatelessWidget {
  const Rejectedmiantenance({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Rejecvm>(context);

    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: StreamBuilder<QuerySnapshot>(
        stream: vm.rejectedMaintenance(),
        builder: (context, snapshot) {
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : null;
          final doc = snapshot.data?.docs ?? [];
          doc.isEmpty == true
              ? Center(child: Text('no rejected maintenance records found'))
              : null;
          return ListView.builder(
            itemCount: doc.length,
            itemBuilder: (context, index) {
              final data = doc[index].data() as Map<String, dynamic>?;
              return Card(
                child: Column(
                  children: [
                    Text(
                      'Rejected Maintenanance❌',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    TitleAndData(
                      tittle: 'barcode',
                      data: data?['barcode'] ?? '',
                    ),
                    TitleAndData(
                      tittle: 'created by',
                      data: data?['created_by'] ?? '',
                    ),
                    TitleAndData(
                      tittle: 'maintenance_id',
                      data: data?['maintenance_id'],
                    ),
                    TitleAndData(tittle: 'brand', data: data?['brand']),
                    if (data?['created_at'] != null)
                      TitleAndData(
                        tittle: 'created date',
                        data: (data?['created_at'] as Timestamp)
                            .toDate()
                            .toString(),
                      ),

                    TitleAndData(
                      tittle: 'ip address',
                      data: data?['ip_address'],
                    ),
                    TitleAndData(
                      tittle: 'maintenance date',
                      data: (data?['matintance data'] as Timestamp)
                          .toDate()
                          .toString(),
                    ),
                    TitleAndData(tittle: 'mac address', data: data?['mac']),
                    TitleAndData(tittle: 'model', data: data?['model']),
                    TitleAndData(tittle: 'ram', data: data?['ram']),
                    TitleAndData(tittle: 'name', data: data?['name']),
                    SizedBox(height: 15),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
