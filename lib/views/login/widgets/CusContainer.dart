import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';

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
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      //if wrong data enter it show massage
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
                    if (widget.formKey.currentState!.validate()) {
                      bool success = await login(
                        emailController.text.trim(),
                        passController.text.trim(),
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login successfully')),
                        );

                        Navigator.pushNamed(context, RoutesNames.home);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid email or password'),
                          ),
                        );
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
