import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';

import 'package:qpi_eng/model/Preventive%20Model/PrevenModel.dart';

class PreventiveMaintenance extends StatefulWidget {
  final GlobalKey _widgetKey = GlobalKey();
  PreventiveMaintenance({super.key});

  @override
  State<PreventiveMaintenance> createState() => _PreventiveMaintenanceState();
}

// getting current user role
Future<String> getRole() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();
  return doc.exists ? doc.data()!['role'] as String : 'user';
}

class _PreventiveMaintenanceState extends State<PreventiveMaintenance> {
  bool sparepartsUsed = false;
  bool yearlyMaintence = true;

  bool canCreateMaintenance = false;
  bool isInitializing = true;
  Duration remainingTime = Duration.zero;
  bool _loadedOnce = false;

  Timer? _timer;

  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modeController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _ipController = TextEditingController();
  final ramController = TextEditingController();
  final macController = TextEditingController();
  final hardDiskController = TextEditingController();

  PrevenModel? product;

  DateTime? nextAllowedMaintenanceDate;
  DateTime now = DateTime.now();

  // 🔹 NEXT MAINTENANCE DATE
  DateTime getNextMaintenance(String scheduleType) {
    DateTime now = DateTime.now();
    if (scheduleType == 'quarterly') {
      return DateTime(now.year, now.month + 3, now.day);
    }
    if (scheduleType == 'half_yearly') {
      return DateTime(now.year, now.month + 6, now.day, now.hour);
    }
    return DateTime(now.year + 1, now.month, now.day);
  }

  // 🔹 FETCH LATEST NEXT_MAINTENANCE (GLOBAL)
  Future<void> checkNextMaintenaceAllowed() async {
    setState(() {
      isInitializing = true;
    });

    final snap = await FirebaseFirestore.instance
        .collection('products')
        .where('next_maintenance', isGreaterThan: DateTime.now())
        .orderBy('next_maintenance')
        .limit(1)
        .get();

    if (!mounted) return;

    if (snap.docs.isEmpty) {
      setState(() {
        canCreateMaintenance = true;
        remainingTime = Duration.zero;
        isInitializing = false;
      });
      return;
    }

    final ts = snap.docs.first['next_maintenance'] as Timestamp;
    nextAllowedMaintenanceDate = ts.toDate();

    isInitializing = false;
    _startCountdown();
  }

  // 🔹 LIVE COUNTDOWN (SECONDS)
  void _startCountdown() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final diff = nextAllowedMaintenanceDate!.difference(now);

      if (diff.isNegative) {
        _timer?.cancel();
        setState(() {
          canCreateMaintenance = true;
          remainingTime = Duration.zero;
        });
      } else {
        setState(() {
          canCreateMaintenance = false;
          remainingTime = diff;
        });
      }
    });
  }

  // 🔹 CREATE MAINTENANCE
  void _createMaintenance() async {
    FocusScope.of(context).unfocus();

    if (_nameController.text.isEmpty ||
        _brandController.text.isEmpty ||
        _modeController.text.isEmpty ||
        _barcodeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final role = await getRole();
    final String scheduleType = yearlyMaintence ? 'half_yearly' : 'quarterly';
    final DateTime nextMaintenance = getNextMaintenance(scheduleType);

    final firestore = FirebaseFirestore.instance;

    final counterRef = firestore
        .collection('counters')
        .doc('corrective_createMaintenance');
    final counterSnap = await counterRef.get();
    int lastNumber = counterSnap.exists ? counterSnap['lastNumber'] : 0;
    int newNumber = lastNumber + 1;

    String maintenanceId = 'CR-00$newNumber';
    await counterRef.set({'lastNumber': newNumber});

    setState(() {
      product = PrevenModel(
        scheduleType: scheduleType,
        nextMaintenanceDate: nextMaintenance,
        status: role == 'admin' ? 'approved' : 'pending',
        maintenanceId: maintenanceId,
        isSparePartsUsed: sparepartsUsed,
        ram: ramController.text.trim(),
        macAddrees: macController.text.trim(),
        hardisk: hardDiskController.text.trim(),
        barcode: _barcodeController.text.trim(),
        name: _nameController.text.trim(),
        brand: _brandController.text.trim(),
        model: _modeController.text.trim(),
        ipAddress: _ipController.text.trim(),
        created_by: role,
      );
    });

    await firestore.collection('products').doc(product!.barcode).set({
      'next_maintenance': nextMaintenance,
      'status': product!.status,
      'created_by': role,
      'maintenance_id': maintenanceId,
      'Spare_parts_used': sparepartsUsed,
      'barcode': product!.barcode,
      'name': product!.name,
      'model': product!.model,
      'brand': product!.brand,
      'matintance data': DateTime.now(),
      'ip_address': product!.ipAddress,
      'ram': product!.ram,
      'mac': product!.macAddrees,
      'Hard_disk': product!.hardisk,
      'created_at': FieldValue.serverTimestamp(),
      'approved': role == 'admin',
      'adminNotification': 1,
    });

    await saveImageToGallery();
    await checkNextMaintenaceAllowed();
  }

  Future<void> saveImageToGallery() async {
    try {
      RenderRepaintBoundary boundary =
          widget._widgetKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getApplicationDocumentsDirectory()).path;
      final file = File(
        '$directory/IMG-${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(pngBytes);
    } catch (_) {}
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loadedOnce) {
      _loadedOnce = true;
      log('PreventiveMaintenance opened');
      checkNextMaintenaceAllowed();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkNextMaintenaceAllowed();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Barcode'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: RepaintBoundary(
          key: widget._widgetKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// ================= DEVICE INFO =================
                _animatedCard(
                  title: 'Device Information',
                  icon: Icons.devices,
                  child: Column(
                    children: [
                      _field(_nameController, 'Device Type', Icons.category),
                      _field(_brandController, 'Brand', Icons.business),
                      _field(_modeController, 'Model', Icons.devices_other),
                      _field(
                        _barcodeController,
                        'Barcode',
                        Icons.qr_code,
                        type: TextInputType.number,
                      ),
                    ],
                  ),
                ),

                /// ================= SYSTEM INFO =================
                _animatedCard(
                  title: 'System Specifications',
                  icon: Icons.memory,
                  child: Column(
                    children: [
                      _field(_ipController, 'IP Address', Icons.router),
                      _field(ramController, 'RAM', Icons.storage),
                      _field(hardDiskController, 'Hard Disk', Icons.sd_storage),
                      _field(
                        macController,
                        'MAC Address',
                        Icons.confirmation_number,
                      ),
                    ],
                  ),
                ),

                /// ================= OPTIONS =================
                _animatedCard(
                  title: 'Maintenance Options',
                  icon: Icons.settings,
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text('Spare parts used'),
                        value: sparepartsUsed,
                        onChanged: (v) => setState(() => sparepartsUsed = v!),
                      ),
                      CheckboxListTile(
                        title: const Text('Half yearly maintenance'),
                        value: yearlyMaintence,
                        onChanged: (v) => setState(() => yearlyMaintence = v!),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= ACTION BUTTONS =================
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Create Maintenance'),
                        onPressed: (!isInitializing && canCreateMaintenance)
                            ? _createMaintenance
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.qr_code_scanner),
                        label: const Text('Scan Barcode'),
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesNames.scanBarCode);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// ================= GENERATED BARCODE =================
                if (product != null)
                  _animatedCard(
                    title: 'Generated Barcode',
                    icon: Icons.qr_code,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(blurRadius: 8, color: Colors.black12),
                            ],
                          ),
                          child: BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: product!.barcode,
                            width: 260,
                            height: 90,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Corr ID: ${product?.maintenanceId ?? "Generating..."}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                /// ================= LOCK MESSAGE =================
                if (!canCreateMaintenance)
                  _animatedCard(
                    title: 'Maintenance Locked',
                    icon: Icons.lock_clock,
                    color: Colors.red.shade50,
                    child: Column(
                      children: [
                        const Text(
                          'Next maintenance is not allowed yet',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${remainingTime.inDays}d '
                          '${remainingTime.inHours % 24}h '
                          '${remainingTime.inMinutes % 60}m '
                          '${remainingTime.inSeconds % 60}s',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedCard({
    required String title,
    required IconData icon,
    required Widget child,
    Color? color,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: Card(
              color: color,
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
                    Row(
                      children: [
                        Icon(icon, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    child,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
