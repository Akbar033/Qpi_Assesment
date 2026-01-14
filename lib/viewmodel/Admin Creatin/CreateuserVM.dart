import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';

class CreateUserVM extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> adminCreateUser(
    String name,
    String lastName,
    String email,
    String password,
    BuildContext context,
    String role,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'email': email,
            'password': password,
            'name': name,
            'last name': lastName,
            'role': role,
          });
      print({userData});

      _isLoading = false;
      notifyListeners();
      print(userCredential);
      Navigator.pushNamed(context, RoutesNames.home);
    } on FirebaseAuth catch (e) {
      print('error occur while creating account $e');
    }
  }
}
