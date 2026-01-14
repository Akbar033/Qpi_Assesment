import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qpi_eng/views/login/Login.dart';

import 'package:qpi_eng/views/splash_Screen/UsserSession/GetUserSession.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // splash screen logic can be added here
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(Duration(seconds: 5), () {
  //     Navigator.pushReplacementNamed(context, '/login');
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  //   });
  // }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => Login()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData.light();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(children: [Lottie.asset('assets/teamwork.json')]),
        ),
      ),
    );
  }
}
