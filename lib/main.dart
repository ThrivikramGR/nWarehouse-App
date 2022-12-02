import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_project/screens/home/home_2.dart';
import 'package:iot_project/screens/home/home_screen.dart';
import 'package:iot_project/screens/home/popup_menu/add_user_screen.dart';
import 'package:iot_project/screens/home/popup_menu/add_warehouse_screen.dart';
import 'package:iot_project/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAknzF4xhhtDqTjBDeU2kMDHJAgxUjL1bA",
      authDomain: "mill-19728.firebaseapp.com",
      projectId: "mill-19728",
      storageBucket: "mill-19728.appspot.com",
      messagingSenderId: "835105755213",
      appId: "1:835105755213:web:cb6b3ebd505ff44c5acc04",
      measurementId: "G-4EGRE4MECW",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String getInitialRoute() {
    if (FirebaseAuth.instance.currentUser == null) {
      return "/";
    } else {
      return "sel";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nWarehouse',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: getInitialRoute(),
      routes: {
        '/': (context) => LoginScreen(),
        'screen4': (context) => AddWarehouseScreen(),
        'addUser': (context) => AddUserScreen(),
        'sel': (context) => HomeScreen(),
        'home2': (context) => HomeScreen2(),
      },
    );
  }
}
