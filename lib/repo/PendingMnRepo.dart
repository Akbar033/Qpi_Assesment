import 'package:cloud_firestore/cloud_firestore.dart';

class LastMaintenanceRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<DateTime?> getLastMaintenance() async {
    final doc = await _firestore
        .collection('products')
        // .where('approve', isEqualTo: true)
        .get();
    if (doc.docs.isEmpty) {
      return null;
    }
    final data = doc.docs.first.data();
    return (data['next_maintenance'] as Timestamp).toDate();
  }
}
