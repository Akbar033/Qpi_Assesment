import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qpi_eng/services/product_services.dart';
import 'package:qpi_eng/test/productdetailscreen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool isProcessing = false;

  String scannedNumber = '';
  String debugMessage = 'Scan a barcode';

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (isProcessing) return;

    final code = capture.barcodes.first.rawValue;
    if (code == null) return;

    setState(() {
      scannedNumber = code;
      debugMessage = 'Scanning...';
    });

    isProcessing = true;
    _controller.stop();

    try {
      final product = await ProductService.fetchProduct(code);

      if (!mounted) return;

      if (product != null) {
        setState(() {
          debugMessage =
              'Product fetched successfully from ${product.source} API';
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        ).then((_) {
          // Resume scanning after returning
          isProcessing = false;
          _controller.start();
        });
      } else {
        setState(() {
          debugMessage = 'Product not found in any API';
        });
        isProcessing = false;
        _controller.start();
      }
    } catch (e) {
      setState(() {
        debugMessage = 'Error fetching product: $e';
      });
      isProcessing = false;
      _controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Product')),
      body: Column(
        children: [
          // Scanner Box
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                MobileScanner(controller: _controller, onDetect: _onDetect),
                Center(
                  child: Container(
                    width: 300,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Debug info area
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Scanned Number: $scannedNumber',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    debugMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
