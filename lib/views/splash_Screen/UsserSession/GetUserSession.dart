import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qpi_eng/views/HomeScreen/HomeScreen.dart';
import 'package:qpi_eng/views/admin%20dashboard/AdminDashboard.dart';

class Getusersession extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  String? userDoc;
  Future<void> logedInUser(BuildContext context) async {
    final currenUser = auth.currentUser;
    if (currenUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currenUser.uid)
          .get();
      final userInfo = doc.exists ? doc.data() : null;
      final role = userInfo != null
          ? userInfo!['role'] as Map<String, dynamic>
          : null;
      log('role is $role');
      if (role == 'admin') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => Admindashboard()),
          );
        });
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => Homescreen()));
      });
    }
    return;
  }
}
