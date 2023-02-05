import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_project/screens/home/home_screen.dart';
import 'package:iot_project/screens/home/popup_menu/add_user_screen.dart';
import 'package:iot_project/screens/home/popup_menu/add_warehouse_screen.dart';
import 'package:iot_project/screens/login_screen.dart';
import 'package:iot_project/workflows/login_flow/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String getInitialRoute() {
    return "sel";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nWarehouse',
      theme: ThemeData(
        primaryColor: Colors.white,
        useMaterial3: true,
        fontFamily: "NunitoSans",
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: getInitialRoute(),
      routes: {
        '/': (context) => LoginPage(),
        'screen4': (context) => AddWarehouseScreen(),
        'addUser': (context) => AddUserScreen(),
        'sel': (context) => HomeScreen(),
      },
    );
  }
}
