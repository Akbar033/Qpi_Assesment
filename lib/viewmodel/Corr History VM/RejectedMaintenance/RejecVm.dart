import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Rejecvm extends ChangeNotifier {
  //this private instance of Firestore means it can only be accessed within this class
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;
  // Rejected Maintenance List
  Stream<QuerySnapshot> rejectedMaintenance() {
    return firestore
        .collection('products')
        .where('status', isEqualTo: 'rejected')
        .snapshots();
  }
}
