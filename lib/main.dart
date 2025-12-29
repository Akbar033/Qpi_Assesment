import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/Utils/Routes/Routes.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/viewmodel/homViewModel.dart';
import 'package:qpi_eng/views/bar_code_generator/barcode_generator.dart';
import 'package:qpi_eng/views/login/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeViewModel())],
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
        RoutesNames.barcodeGenerator: (_) => AddProductScreen(),
      },
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
