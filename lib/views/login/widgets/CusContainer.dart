import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:qpi_eng/views/HomeScreen/HomeScreen.dart';

import 'package:qpi_eng/views/admin%20dashboard/AdminDashboard.dart';

class CusContainer extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CusContainer({super.key});

  @override
  State<CusContainer> createState() => _CusContainerState();
}

class _CusContainerState extends State<CusContainer> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  //login
  Future<bool> login(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("this is user details✔✔${auth.currentUser!.uid}");
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('firebase error occured sorry')));
      print('firebase error❌ $e');
      return false;
    } catch (e) {
      print('other error❌ $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 40,
        shadowColor: Colors.black,
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter correct email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                    focusColor: Colors.blueGrey,
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter your password'
                      : null,
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    bool success = await login(
                      emailController.text.trim(),
                      passController.text.trim(),
                    );
                    if (success) {
                      final uid = FirebaseAuth.instance.currentUser!.uid;
                      final doc = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .get();
                      if (doc.exists) {
                        final data = doc.data()!;
                        if (data['role'] == 'admin') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => Admindashboard()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => Homescreen()),
                          );
                        }
                      }
                    }
                  },

                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
