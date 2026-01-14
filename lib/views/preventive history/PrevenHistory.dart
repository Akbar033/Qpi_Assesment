import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/viewmodel/Corr%20History%20VM/CorrHistoryVM.dart';

class PrevenMnHistory extends StatefulWidget {
  const PrevenMnHistory({super.key});

  @override
  State<PrevenMnHistory> createState() => _PrevenMnHistoryState();
}

class _PrevenMnHistoryState extends State<PrevenMnHistory>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    Future.microtask(() => context.read<Corrhistoryvm>().fetchAllProducts());
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Corrhistoryvm>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance History'),
        centerTitle: true,
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.products.isEmpty
          ? const Center(child: Text('No approved maintenance found'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: vm.products.length,
              itemBuilder: (context, index) {
                final product = vm.products[index];

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 400 + index * 80),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
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
                                  Icon(Icons.history, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
                                    'Approved Maintenance',
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
                                  color: Colors.green.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'COMPLETED',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          /// BARCODE WITH CONTINUOUS PULSE
                          Center(
                            child: AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius:
                                            15 * _pulseController.value + 4,
                                        color: Colors.blue.withOpacity(0.9),
                                      ),
                                    ],
                                  ),
                                  child: BarcodeWidget(
                                    barcode: Barcode.code128(),
                                    data: product['barcode'],
                                    width: 220,
                                    height: 80,
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 12),

                          _info('Barcode', product['barcode']),
                          _info('Name', product['name']),
                          _info('Brand', product['brand']),
                          _info('Model', product['model']),
                          _info('IP Address', product['ip_address']),
                          _info('MAC', product['mac']),
                          _info(
                            'Spare Parts Used',
                            product['Spare_parts_used'] ? 'Yes' : 'No',
                          ),
                          _info('Hard Disk', product['Hard_disk']),
                          _info('Corr ID', product['maintenance_id'] ?? ''),

                          if (product['created_at'] != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                'Created: ${(product['created_at'] as Timestamp).toDate()}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  /// SMALL HELPER (STAYS IN SAME FILE)
  Widget _info(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$title:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(flex: 5, child: Text(value ?? '')),
        ],
      ),
    );
  }
}
