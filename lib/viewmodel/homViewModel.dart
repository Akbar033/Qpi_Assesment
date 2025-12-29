import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchMaintenanceData() {
    return _firestore
        .collection('maintanance_data')
        .orderBy('created_at', descending: true)
        .snapshots();
  }
}
