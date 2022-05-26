import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/screens/home/home_screen.dart';
import 'package:iot_project/screens/home/popup_menu/add_user_screen.dart';
import 'package:iot_project/screens/home/popup_menu/add_warehouse_screen.dart';
import 'package:iot_project/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //For flutter web initialization, initialize it with firebase options
  //inside the try catch block, to suppress exception sometimes as and when
  //flutter initializes firebase twice for some reason
  //try {
  await Firebase.initializeApp();
  //} catch (e) {}

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Project App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'sel',
      routes: {
        '/': (context) => LoginScreen(),
        'screen4': (context) => AddWarehouseScreen(),
        'addUser': (context) => AddUserScreen(),
        'sel': (context) => HomeScreen(),
      },
    );
  }
}
//todo: forget password and user not registered: show dialog box "Contact Admins"
//todo: all dialog boxes change text color to primary color
//todo: finish up choose detailed report screen
//todo: extract and backup "backup" directory to ssd
//todo: change loading spinner of nodes screen to spinkit
//todo: move local colors to colorConfig
