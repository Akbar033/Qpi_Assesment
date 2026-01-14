import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qpi_eng/views/login/Login.dart';

class Adminvm extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loggingOut = false;

  Future<Map<String, dynamic>?> fetchUserName() async {
    final user = auth.currentUser;
    if (user == null) return null;

    final doc = await firestore.collection('users').doc(user.uid).get();
    return doc.exists ? doc.data() : null;
  }

  Future<void> logOut(BuildContext context) async {
    loggingOut = true;
    notifyListeners();
    final user = auth.currentUser;
    if (user == null) return;
    log('logging out${user.email ?? ''}');
    await auth.signOut();
    loggingOut = false;
    notifyListeners();

    Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
    auth.authStateChanges().listen((details) {});
  }

  /// 🔔 Admin notification count
  Stream<int> notificationCount() {
    return firestore
        .collection('products')
        .where('approved', isEqualTo: false)
        .snapshots()
        .map((snap) => snap.docs.length);
  }

  /// Pending maintenance list with filters
  Stream<QuerySnapshot> pendingMaintenance() {
    return firestore
        .collection('products')
        .where('approved', isEqualTo: false)
        .where('created_by', isNotEqualTo: 'admin')
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  /// Approve maintenance with status update and remove notification
  Future<void> approveMaintenance(String barcode) async {
    await firestore.collection('products').doc(barcode).update({
      'approved': true,
      'adminNotification': 0,
    });
  }

  //Rejected maintenance with status update and romve notification
  Future<void> rejectMaintenance(String barcode) async {
    await firestore
        .collection('products')
        .doc(barcode)
        .delete(
          //   {
          //   'status': 'rejected',
          //   'adminNotification': 0,
          // }
        );
  }
}
