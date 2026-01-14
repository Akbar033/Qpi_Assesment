import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  final ScrollController _scrollController = ScrollController();
  bool isScanned = false;
  MobileScannerController scannerController = MobileScannerController(
    // formats: [
    //   BarcodeFormat.code128,
    //   BarcodeFormat.code39,
    //   BarcodeFormat.code93,
    //   BarcodeFormat.ean13,
    //   BarcodeFormat.ean8,
    //   BarcodeFormat.upcA,
    //   BarcodeFormat.upcE,
    //   BarcodeFormat.itf,
    // ],
    torchEnabled: false,
  );
  DateTime? maintanance;
  String? scannedBarcode;
  Map<String, dynamic>? productData;
  bool isLoading = false;
  String errorMessage = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scannerController.dispose();
  }

  /// 🔹 FETCH PRODUCT FROM FIRESTORE
  Future<void> fetchProduct(String barcode) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      productData = null;
    });

    try {
      final doc = await FirebaseFirestore.instance
          .collection('products')
          .doc(barcode) // barcode as document ID
          .get();

      if (doc.exists) {
        productData = doc.data() as Map<String, dynamic>;
        Timestamp ts = productData!['last_time matintance'];
        maintanance = ts.toDate();
        //scroll up automatically
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            100,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        });
      } else {
        errorMessage = 'No product found for this barcode';
      }
    } catch (e) {
      errorMessage = 'Error fetching data';
    }

    setState(() {
      isLoading = false;
    });
  }

  void _toggleTourch() {
    scannerController.toggleTorch();
  }

  /// 🔹 HANDLE BARCODE SCAN
  void onDetect(BarcodeCapture capture) {
    if (isScanned) return;

    // isScanned = true;
    // scannerController.stop();

    final barcode = capture.barcodes.first.rawValue;

    if (barcode != null && scannedBarcode == null) {
      isScanned = true;
      scannedBarcode = barcode;
      scannerController.stop();
      fetchProduct(barcode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
        actions: [
          IconButton(
            onPressed: () {
              _toggleTourch();
            },
            icon: Icon(Icons.flashlight_on),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            /// 🔹 SCANNER VIEW
            if (!isScanned)
              SizedBox(
                height: 250,
                child: MobileScanner(
                  onDetect: onDetect,
                  //onDetect: onDetect,
                  controller: scannerController,
                ),
              ),

            const SizedBox(height: 20),

            /// 🔹 LOADING
            if (isLoading) Center(child: const CircularProgressIndicator()),

            /// 🔹 ERROR MESSAGE
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),

            /// 🔹 SHOW PRODUCT DATA
            if (productData != null) ...[
              Center(
                child: Text(
                  'Details',
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Device :    ${productData!['name']}',
                style: const TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Brand:   ${productData!['brand']}',
                style: const TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'model:   ${productData!['model']}',
                style: const TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Barcode:   ${productData!['barcode']}',
                style: const TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text('ip_address:  ${productData!['ip_address']}'),
              SizedBox(height: 30),
              if (maintanance != null)
                Card(
                  shadowColor: Colors.black,
                  elevation: 20,
                  child: Container(
                    height: 40,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'last maintanance:   ${maintanance!.toLocal()}',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 68, 22, 19),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
