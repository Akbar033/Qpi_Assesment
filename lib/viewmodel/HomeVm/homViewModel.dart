import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  final String _errorMassage = '';
  String get errorMassage => _errorMassage;

  Stream<QuerySnapshot> fetchedData(BuildContext context) {
    return FirebaseFirestore.instance
        .collection('maintanance_data')
        .orderBy('created_at', descending: true)
        .snapshots();
  }
}
