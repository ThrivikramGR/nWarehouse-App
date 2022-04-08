import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/screens/login_screen.dart';
import 'package:iot_project/screens/screen2.dart';
import 'package:iot_project/screens/screen4.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Project App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        'screen2': (context) => Screen2(),
        'screen4': (context) => Screen4(),
      },
    );
  }
}
