import 'package:flutter/material.dart';
import 'package:qpi_eng/Bar_Scanner/BarCodeScanner.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/test/scannerscreen.dart';
import 'package:qpi_eng/views/HomeScreen/HomeScreen.dart';
import 'package:qpi_eng/views/bar_code_generator/barcode_generator.dart';
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

      case RoutesNames.addProductScreen:
        return MaterialPageRoute(
          builder: (BuildContext contex) => AddProductScreen(),
        );

      /* case RoutesNames.barcodeGenerator:
        return MaterialPageRoute(builder: (_) => const BarcodeGenerator());*/

      case RoutesNames.scanBarCode:
        return MaterialPageRoute(
          //app need
          builder: (BuildContext contex) => BarcodeScanner(),
        );

      default:
        return MaterialPageRoute(builder: (_) => Homescreen());
    }

    //default case if there is no such route
  }
}
