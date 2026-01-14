import 'package:flutter/material.dart';
import 'package:qpi_eng/Bar_Scanner/BarCodeScanner.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/test/scannerscreen.dart';
import 'package:qpi_eng/views/preventive%20history/PrevenHistory.dart';
import 'package:qpi_eng/views/Create%20User/CreateUser.dart';
import 'package:qpi_eng/views/HomeScreen/HomeScreen.dart';
import 'package:qpi_eng/views/Pending%20Maintenance/PenMaintenance.dart';
import 'package:qpi_eng/views/Preventive%20Maintenance/PrevenMaintenance.dart';
import 'package:qpi_eng/views/admin%20dashboard/AdminDashboard.dart';

import 'package:qpi_eng/views/corre%20Mainten/CRM.dart';

import 'package:qpi_eng/views/login/Login.dart';
import 'package:qpi_eng/views/signup/Signup.dart';
import 'package:qpi_eng/views/splash_Screen/splashScree.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //switch case to manage the routes
    switch (settings.name) {
      //navigate to login screen
      case RoutesNames.login:
        return MaterialPageRoute(builder: (BuildContext contex) => Login());
      //navigate to signup screen
      case RoutesNames.signup:
        return MaterialPageRoute(builder: (BuildContext contex) => Signup());
      //navigate to splash screen
      case RoutesNames.splash:
        return MaterialPageRoute(
          builder: (BuildContext contex) => SplashScreen(),
        );
      //navigate to barcode scan screen
      //case RoutesNames.barcodeScan:
      // return MaterialPageRoute(builder: (_) => BarcodeScannerScreen());
      //route for scanner screen
      case RoutesNames.scannerScreen:
        return MaterialPageRoute(
          builder: (BuildContext contex) => const ScannerScreen(),
        );

      case RoutesNames.prevenMn:
        return MaterialPageRoute(
          builder: (BuildContext contex) => PreventiveMaintenance(),
        );
      case RoutesNames.scanBarCode:
        return MaterialPageRoute(
          //app need
          builder: (BuildContext contex) => BarcodeScanner(),
        );
      //create user by admin
      case RoutesNames.createUser:
        return MaterialPageRoute(
          builder: (BuildContext context) => CreateUser(),
        );
      //corrective maintenance history
      case RoutesNames.prevenMnHistory:
        return MaterialPageRoute(builder: (cotext) => PrevenMnHistory());
      //pending maintenance
      case RoutesNames.pendingMaintenance:
        return MaterialPageRoute(builder: (context) => PendingMaintenance());
      //admin dashboard
      case RoutesNames.adminDashboard:
        return MaterialPageRoute(builder: (context) => Admindashboard());
      //corrective maintence route  route
      case RoutesNames.correctiveMaintenance:
        return MaterialPageRoute(
          builder: (context) => CreateCorrectiveMaintenance(),
        );
      default:
        return MaterialPageRoute(builder: (_) => Homescreen());
    }
  }
}
