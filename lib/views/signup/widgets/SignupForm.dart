import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';

class Signupform extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Signupform({super.key});

  @override
  State<Signupform> createState() => _SignupformState();
}

class _SignupformState extends State<Signupform> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final adminController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  //create adminaccount
  Future<void> createAdmin(
    String email,
    String password,
    String name,
    String lastTime,
    String role,
  ) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'password': password,
          'name': name,
          'last name': lastTime,
          'role': 'admin',
        });
        print(user);
      }
    } on FirebaseAuthException catch (e) {
      print('error is occured❌❌$e');
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Card(
        surfaceTintColor: Colors.blueGrey,
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  //name textform
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    controller: nameController,
                  ),

                  //last
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'Last'),
                  ),

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
                  SizedBox(height: 5),
                  TextFormField(
                    controller: passController,
                    decoration: InputDecoration(labelText: 'password'),
                    obscureText: false,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter your password'
                        : null,
                  ),
                  // SizedBox(height: 5),
                  // TextFormField(
                  //   decoration: InputDecoration(labelText: 'id'),
                  //   keyboardType: TextInputType.number,
                  //   controller: idController,
                  //   validator: (value) {
                  //     (value == null || value.isEmpty)
                  //         ? 'please enter id number'
                  //         : null;
                  //   },
                  // ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(0, 6, 59, 14),
                      ),
                    ),
                    //logic for validation if fields are correct
                    onPressed: () {
                      if (widget.formKey.currentState!.validate()) {
                        createAdmin(
                          emailController.text.trim(),
                          passController.text.trim(),
                          nameController.text.trim(),
                          lastNameController.text.trim(),
                          'admin',
                        );

                        Navigator.pushNamed(context, RoutesNames.login);
                        // If the form is valid, display a snackbar. In a real app,
                        // you'd often call a server or save the information in a database.
                      }
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
