/*import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart' hide Barcode;
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart' as gen; // generator
import 'package:flutter/services.dart';


import 'package:qpi_eng/model/barcode_model.dart/barcode_model.dart';
import 'package:qpi_eng/test/scannerscreen.dart';

class BarcodeGenerator extends StatefulWidget {
  const BarcodeGenerator({super.key});

  @override
  State<BarcodeGenerator> createState() => _BarcodeGeneratorState();
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {
  final TextEditingController _textController = TextEditingController();
  

  // Example barcode value
  String barcode = '123456789012';
  //the below variable is used to keep track of the selected index of the bottom navigation bar
  int selectedIndex = 0;
  // List of barcode types and their corresponding Barcode objects
  final List<BarcodeOption> _barcodTypeList = [
    BarcodeOption('Code 128', gen.Barcode.code128()),
    BarcodeOption('Code 39', gen.Barcode.code39()),
    BarcodeOption('Code 93', gen.Barcode.code93()),
    BarcodeOption('EAN-13', gen.Barcode.ean13()),
    BarcodeOption('EAN-8', gen.Barcode.ean8()),
    BarcodeOption('UPC-A', gen.Barcode.upcA()),
    BarcodeOption('UPC-E', gen.Barcode.upcE()),
    BarcodeOption('ITF', gen.Barcode.itf()),
    BarcodeOption('Pdf ', gen.Barcode.pdf417()),
    BarcodeOption('Data Matrix', gen.Barcode.dataMatrix()),
    BarcodeOption('QR Code', gen.Barcode.qrCode()),
  ];

  //this getter returns the selected barcode type based on the selected index
  gen.Barcode get _selectedBarcodeType =>
      _barcodTypeList[selectedIndex].barcode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.text = barcode;
  }

  void generateBarcode() {
    setState(() {
      barcode = _textController.text.isEmpty
          ? '123456789'
          : _textController.text;
    });
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: barcode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barcode value copied to clipboard')),
    );
  }

  Widget _buildBarcodeWidget() {
    try {
      //container with boxshadow ,border radius and padding
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: BarcodeWidget(
          barcode: _selectedBarcodeType as gen.Barcode,
          data: barcode,
          width: 200,
          height: 100,
          drawText: true,
        ),
      );
    } catch (e) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(color: Colors.redAccent),
        ),
        child: const Column(
          children: [
            Icon(Icons.error, color: Colors.red, size: 48),
            SizedBox(height: 8),
            Text(
              'Error generating barcode',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 30),
            Text(
              'The selected barcode type may not support the provided data.',
              style: TextStyle(color: Colors.redAccent, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ScannerScreen()),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text('Barcode Generator'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F7FA), Color(0xFF80DEEA), Color(0xFF26C6DA)],
          ),
        ),
        child: Card(
          //card with round shape and shade shadow color
          shape: Border.all(color: Colors.grey),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBarcodeWidget(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter barcode value',
                    suffix: IconButton(
                      onPressed: _textController.clear,
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (value) {
                    generateBarcode();
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: generateBarcode,
                child: const Text('Generate Barcode'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: copyToClipboard,
                child: const Text('Copy to Clipboard'),
              ),

              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScannerScreen()),
                  );
                },
                child: Text('Scan bar code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/model/barcode_model.dart/barcode_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  //list for dropdown widget
  final List<String> deviceType = [
    'camera',
    'pc',
    'water',
    'chamber',
    'scanner',
    'router',
  ];

  String? selectedDeviceType;

  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modeController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _ipController = TextEditingController();

  ProductModel? product;

  void _createProduct() {
    //below line used for hiding keyboard automaticcally
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

    setState(() {
      product = ProductModel(
        barcode: _barcodeController.text.trim(),
        name: _nameController.text.trim(),
        brand: _brandController.text.trim(),
        model: _modeController.text.trim(),
        ipAddress: _ipController.text.trim(),
      );
    });
    saveBarcodeData_to_Firestore(product!);
  }

  //function for saving barcode
  Future<void> saveBarcodeData_to_Firestore(ProductModel product) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('products').doc(product.barcode).set({
        'barcode': product.barcode,
        'name': product.name,
        'model': product.model,
        'brand': product.brand,
        'last_time matintance': DateTime.now(),
        'ip_address': product.ipAddress,
      });
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return
    // WillPopScope(
    //   // onWillPop: () async {
    //   //   // used for close app if there is no route defined
    //   //   SystemNavigator.pop();
    //   //   return true;
    //   // },
    //   child:
    Scaffold(
      appBar: AppBar(title: const Text('Create Barcode')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //code for dropdown button
            /*  DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Device Type',
                  border: OutlineInputBorder(),
                ),
                value: selectedDeviceType,
                items: deviceType.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDeviceType = value;
                  });
                },
              ),*/
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Device type'),
            ),
            TextField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            TextField(
              controller: _modeController,
              decoration: InputDecoration(labelText: 'Model'),
            ),

            TextField(
              controller: _barcodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Barcode (numbers only)',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: 'ip address(Only number)',
              ),
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                ElevatedButton(
                  onPressed: _createProduct,

                  child: const Text('Create Barcode'),
                ),
                SizedBox(width: 30),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesNames.scanBarCode);
                  },

                  child: const Text(
                    'Scan bar code',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            if (product != null) ...[
              /// BARCODE IMAGE
              BarcodeWidget(
                barcode: Barcode.code128(),
                data: product!.barcode,
                width: 300,
                height: 100,
              ),

              const SizedBox(height: 20),

              Text(
                'Name: ${product!.name}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Brand: ${product!.brand}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Model: ${product!.model}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Barcode: ${product!.barcode}',
                style: const TextStyle(color: Colors.grey),
              ),
              Text('ipadress:${product!.ipAddress}'),
              Text('${DateTime.now()}'),

              SizedBox(height: 40),

              // Row(
              //   children: [
              //     //text for successfully created barcode
              //     Text(
              //       'BarCode Generated',
              //       style: TextStyle(color: Colors.blueAccent, fontSize: 15),
              //     ),
              //     //for tick mark icon
              //     Icon(Icons.check_circle, fill: 15, color: Colors.green),
              //   ],
              // ),

              //elevated butoon for navigation to scanner for barcode
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesNames.scanBarCode);
                },
                child: Text('Scan Barcode'),
              ),
            ],
          ],
        ),
      ),
      //),
    );
  }
}
