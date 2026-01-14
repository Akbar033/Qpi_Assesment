//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/viewmodel/adminiDashoboard/AdminVm.dart';

class PendingMaintenance extends StatelessWidget {
  const PendingMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Adminvm>(context);
    //TextEditingController reasonController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Maintenance')),
      body: StreamBuilder(
        stream: vm.pendingMaintenance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final doc = snapshot.data?.docs;
          if (doc?.isEmpty == true || doc == null) {
            return const Center(child: Text('no pending maintenance'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: doc.length,
            itemBuilder: (context, index) {
              final data = doc[index].data() as Map<String, dynamic>;

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: Opacity(opacity: value, child: child),
                  );
                },
                child: Card(
                  elevation: 6,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.build, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  'Maintenance Request',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'PENDING',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// BASIC INFO
                        _infoRow(Icons.qr_code, 'Barcode', data['barcode']),
                        _infoRow(
                          Icons.person,
                          'Created by',
                          data['created_by'],
                        ),

                        const SizedBox(height: 8),

                        /// EXPAND DETAILS
                        ExpansionTile(
                          title: const Text(
                            'View Details',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          childrenPadding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          children: [
                            _infoRow(Icons.devices, 'Brand', data['brand']),
                            _infoRow(Icons.memory, 'RAM', data['ram']),
                            _infoRow(Icons.router, 'IP', data['ip_address']),
                            _infoRow(
                              Icons.confirmation_number,
                              'MAC',
                              data['mac'],
                            ),
                            _infoRow(
                              Icons.calendar_today,
                              'Maintenance Date',
                              (data['matintance data'] as Timestamp)
                                  .toDate()
                                  .toString(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// REASON
                        // TextField(
                        //   decoration: InputDecoration(
                        //     labelText: 'Rejection Reason',
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 16),

                        /// ACTION BUTTONS
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.close),
                                label: const Text('Reject'),
                                onPressed: () {
                                  vm.rejectMaintenance(data['barcode']);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.check),
                                label: const Text('Approve'),
                                onPressed: () {
                                  vm.approveMaintenance(data['barcode']);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text('$title:', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 6),
          Expanded(child: Text(value ?? '', overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
