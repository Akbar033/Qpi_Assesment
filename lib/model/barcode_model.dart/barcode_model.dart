/*import 'package:barcode_widget/barcode_widget.dart' as gen;

class BarcodeOption {
  final String name;
  final gen.Barcode barcode;
  

  BarcodeOption(this.name, this.barcode, );
}*/

class ProductModel {
  final String barcode;
  final String name;
  final String brand;
  final String model;
  final String ipAddress;

  ProductModel({
    required this.barcode,
    required this.name,
    required this.brand,
    required this.model,
    required this.ipAddress,
  });
}
