import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qpi_eng/Utils/Colors/AppColors.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';

import 'package:qpi_eng/views/login/widgets/CusContainer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // welcome text go here
                RichText(
                  text: TextSpan(
                    text: 'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.textColor,
                      //using google fonts
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    children: [
                      TextSpan(
                        text: '\nSign in to continue',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 14, 13, 12),
                          //using google fonts
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                CusContainer(),

                SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesNames.signup);
                  },
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(left: 70),
                    child: RichText(
                      text: TextSpan(
                        text: 'dont have an account',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'SignUp',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
