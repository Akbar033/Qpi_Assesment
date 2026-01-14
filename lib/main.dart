import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/Utils/Routes/Routes.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/viewmodel/Admin%20Creatin/CreateuserVM.dart';
import 'package:qpi_eng/viewmodel/Corr%20History%20VM/CorrHistoryVM.dart';
import 'package:qpi_eng/viewmodel/Corr%20History%20VM/RejectedMaintenance/RejecVm.dart';
import 'package:qpi_eng/viewmodel/adminiDashoboard/AdminVm.dart';
import 'package:qpi_eng/viewmodel/HomeVm/homViewModel.dart';

import 'package:qpi_eng/views/Preventive%20Maintenance/PrevenMaintenance.dart';
import 'package:qpi_eng/views/login/Login.dart';
//import 'package:qpi_eng/views/login/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CreateUserVM()),
        ChangeNotifierProvider(create: (_) => Adminvm()),
        ChangeNotifierProvider(create: (_) => Corrhistoryvm()),
        ChangeNotifierProvider(create: (_) => Rejecvm()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(),
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // initialRoute: RoutesNames.SplashView,
      initialRoute: RoutesNames.splash,
      //this route is used to navigate between screens
      routes: {
        RoutesNames.login: (_) => Login(),
        // first it was barcode after that we convert in into PreventiveMaintenance
        RoutesNames.barcodeGenerator: (_) => PreventiveMaintenance(),
      },
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
