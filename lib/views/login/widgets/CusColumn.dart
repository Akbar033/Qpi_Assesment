/*import 'package:flutter/material.dart';

class CusColumn extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirmPassword;
  // reuired this is for  login and signup form fields to be pressed
  void Function()? onTap;
  final String? buttonText;

  CusColumn({
    super.key,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    required this.onTap,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //name text field with validation
        if (firstName != null)
          TextField(decoration: InputDecoration(labelText: firstName))
          else ,
        //last name text field with validation
        if (lastName != null)
          TextField(decoration: InputDecoration(labelText: lastName)),
        //email text field with validation
        if (email != null)
          TextField(decoration: InputDecoration(labelText: email)),
        //password text field with validation
        if (password != null)
          TextField(
            decoration: InputDecoration(labelText: password),
            obscureText: true,
          ),
        //confirm password text field with validation
        if (confirmPassword != null)
          ElevatedButton(onPressed: onTap, child: Text(buttonText ?? 'Submit')),
      ],
    );
  }
}*/
