import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_project/screens/home/popup_menu/add_user_screen.dart';
import 'package:iot_project/screens/home/popup_menu/add_warehouse_screen.dart';
import 'package:iot_project/workflows/home_warehouse/home_page.dart';
import 'package:iot_project/workflows/login_signup/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      initialRoute: "/",
      routes: {
        '/': (context) => InitRoutingPage(),
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
        'screen4': (context) => AddWarehouseScreen(),
        'addUser': (context) => AddUserScreen(),
      },
    );
  }
}

class InitRoutingPage extends StatefulWidget {
  const InitRoutingPage({Key? key}) : super(key: key);
  @override
  State<InitRoutingPage> createState() => _InitRoutingPageState();
}

class _InitRoutingPageState extends State<InitRoutingPage> {
  Future<void> initRouteNav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    if (email == null) {
      Navigator.pushReplacementNamed(context, "login");
    } else {
      Navigator.pushReplacementNamed(context, "home");
    }
  }

  @override
  void initState() {
    initRouteNav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
