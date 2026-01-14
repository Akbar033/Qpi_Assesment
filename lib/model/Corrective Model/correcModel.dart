import 'package:qpi_eng/model/Maint%20Base%20Model/MainBaseModel.dart';

class Correcmodel extends Mainbasemodel {
  final String issuedReport;
  final String machineType;
  final String malFunctionReason;

  Correcmodel({
    required this.issuedReport,
    required this.machineType,
    required this.malFunctionReason,
    required super.isFaultFixed,
    required super.startdate,
    required super.endDate,
    required super.mainStatus,
    required super.sparepartsUsed,
  });
  // from firestore
  factory Correcmodel.fromFirestore(Map<String, dynamic> map) {
    return Correcmodel(
      endDate: map['end_date'] as DateTime,
      isFaultFixed: map['is_fault_fixed'] as bool,
      issuedReport: map['issued_reports'],
      machineType: map['machine_type'],
      malFunctionReason: map['malfunction_reason'],
      mainStatus: map['main_status'],
      sparepartsUsed: map['spareparts_used'],
      startdate: map['start_date'] as DateTime,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'issued_reports': issuedReport,
      'machine_type': machineType,
      'malfunction_reason': malFunctionReason,
      ' is_fault_fixed': isFaultFixed,
      'start_date': startdate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'main_status': mainStatus,
      'spareparts_used': sparepartsUsed,
    };
  }
}
