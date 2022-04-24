import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/new_screens/login_screen.dart';
import 'package:iot_project/screens/screen2.dart';
import 'package:iot_project/screens/screen4.dart';
import 'package:iot_project/services/color_config.dart';

import 'new_screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAknzF4xhhtDqTjBDeU2kMDHJAgxUjL1bA",
        authDomain: "mill-19728.firebaseapp.com",
        projectId: "mill-19728",
        storageBucket: "mill-19728.appspot.com",
        messagingSenderId: "835105755213",
        appId: "1:835105755213:web:45a39759098a91e15acc04",
        measurementId: "G-JV2476JHEZ",
      ),
    );
  } catch (e) {}

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Project App',
      theme: ThemeData(
        primaryColor: ColorConfig.primaryBlue,
        scaffoldBackgroundColor: ColorConfig.backgroundLightBlue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        '/': (context) => LoginScreen(),
        'screen2': (context) => Screen2(),
        'screen4': (context) => Screen4(),
        'home': (context) => HomeScreen(),
        //'newHome': (context) => WarehouseHomePage(),
      },
    );
  }
}
