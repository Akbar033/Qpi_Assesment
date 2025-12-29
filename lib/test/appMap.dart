import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> maintananceData = {
  'created_at': FieldValue.serverTimestamp(),
  'type': {'malfunctiontype': '', 'deviceType': '', 'reason': ''},
  'machine status': {
    'fault stop machine': false,
    'reason why stop machine': '',
  },
  'malfunction reason': {'reason': '', 'malfunction comment': ''},
  'fault fixed': {'is_fault_fixed': false, 'fault_fixed_comment': ''},
  'Spare_parts': {'sprareparts_comment': '', 'spare_parts_used': false},
  'start_date': {'maintenance_date': '', 'maintenance_comment': ''},
  'end_date': {'maintenance_end_date': '', 'end_date_comment': ''},
  'Description': {'report_description': '', 'Complete Description': ''},
  'timeCreation': {
    'created_at'
        '${Timestamp.now()}',
  },
};
