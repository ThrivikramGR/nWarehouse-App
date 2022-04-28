import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_project/custom_widgets/scaffold_elements.dart';
import 'package:iot_project/new_screens/drawer_pages/alerts_page.dart';
import 'package:iot_project/new_screens/drawer_pages/help_page.dart';
import 'package:iot_project/new_screens/drawer_pages/notifications_page.dart';
import 'package:iot_project/new_screens/drawer_pages/select_warehouse_page.dart';
import 'package:iot_project/new_screens/drawer_pages/userProfile_page.dart';
import 'package:iot_project/services/color_config.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  final String? username;

  HomeScreen({this.username = "martin"});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  late Map<int, Map<String, dynamic>> drawerPages = {
    0: {
      "widget": SelectWarehousePage(
        username: widget.username!,
      ),
      "appBarTitle": "nWarehouse",
    },
    1: {
      "widget": UserProfilePage(
        username: widget.username!,
      ),
      "appBarTitle": "",
    },
    2: {
      "widget": NotificationsPage(),
      "appBarTitle": "",
    },
    3: {
      "widget": AlertsPage(),
      "appBarTitle": "",
    },
    4: {
      "widget": HelpPage(),
      "appBarTitle": "",
    },
  };

  void drawerItemOnTapHandler(int page) {
    Navigator.pop(context);
    if (currentPage != page) {
      setState(() {
        currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: ColorConfig.backgroundLightBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                decoration: BoxDecoration(
                  color: ColorConfig.primaryBlue,
                ),
                child: Row(
                  children: [
                    Icon(
                      LineIcons.userCircle,
                      color: Colors.white,
                      size: 45,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.username![0].toUpperCase() +
                          widget.username!.substring(1),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                LineIcons.warehouse,
              ),
              title: Text(
                "Warehouse",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {
                drawerItemOnTapHandler(0);
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.user,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {
                drawerItemOnTapHandler(1);
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.bell,
              ),
              title: Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {
                drawerItemOnTapHandler(2);
              },
            ),
            ListTile(
              leading: Icon(LineIcons.exclamation),
              title: Text(
                "Alerts",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {
                drawerItemOnTapHandler(3);
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.question,
              ),
              title: Text(
                "Help",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {
                drawerItemOnTapHandler(4);
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.alternateSignOut,
                color: Colors.red,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {
                if (Platform.isAndroid) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Logout"),
                      content: Text(
                        "Confirm logout?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            _auth.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (Route<dynamic> route) => false);
                          },
                          child: const Text("Logout"),
                        ),
                      ],
                    ),
                  );
                } else {
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const Text("Logout"),
                      content: Text(
                        "Confirm logout?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            _auth.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (Route<dynamic> route) => false);
                          },
                          child: const Text("Logout"),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      appBar: CustomScaffoldElements.getAppBar(
          drawerPages[currentPage]!["appBarTitle"]),
      body: drawerPages[currentPage]!["widget"],
    );
  }
}
