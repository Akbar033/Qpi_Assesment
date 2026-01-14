import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Corrhistoryvm extends ChangeNotifier {
  bool isLoading = false;
  List<Map<String, dynamic>> products = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchAllProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      // Fetch all products (without composite query)
      final snapshot = await firestore
          .collection('products')
          .orderBy('created_at', descending: true) // single field ordering
          .get();

      // Filter approved products client-side
      products = snapshot.docs
          .map((doc) => {'barcode': doc.id, ...doc.data()})
          .where((prod) => prod['approved'] == true) // only approved
          .toList();

      print('✔ Fetched approved products: $products');
    } catch (e) {
      products = [];
      print('❌ Error fetching products: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
