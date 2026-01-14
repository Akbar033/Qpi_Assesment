/*import 'package:barcode_widget/barcode_widget.dart' as gen;

class BarcodeOption {
  final String name;
  final gen.Barcode barcode;
  

  BarcodeOption(this.name, this.barcode, );
}*/

class PrevenModel {
  //final bool isSDD = false;
  DateTime? nextMaintenanceDate;
  String scheduleType;
  final maintenanceId;
  final String barcode;
  final String name;
  final String brand;
  final String model;
  final String ipAddress;
  final String macAddrees;
  final String ram;
  final String hardisk;
  final bool isSparePartsUsed;
  final String created_by;
  final String status;

  PrevenModel({
    this.nextMaintenanceDate,
    required this.scheduleType,
    required this.status,
    required this.created_by,
    required this.maintenanceId,
    required this.isSparePartsUsed,
    required this.barcode,
    required this.name,
    required this.brand,
    required this.model,
    required this.ipAddress,
    required this.macAddrees,
    required this.ram,
    required this.hardisk,
  });
}
