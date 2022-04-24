import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/custom_widgets/scaffoldElements.dart';
import 'package:iot_project/new_screens/drawer_pages/profile_page.dart';
import 'package:iot_project/new_screens/drawer_pages/select_warehouse_page.dart';
import 'package:iot_project/services/color_config.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  HomeScreen({this.userName = "Guest"});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  late Map<int, Map<String, dynamic>> drawerPages = {
    0: {
      "widget": SelectWarehousePage(),
      "appBarTitle": "Select Warehouse",
    },
    1: {
      "widget": ProfilePage(
        username: widget.userName!,
      ),
      "appBarTitle": "My Profile",
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
                      Icons.account_circle,
                      color: Colors.white,
                      size: 45,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.userName![0].toUpperCase() +
                          widget.userName!.substring(1),
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
                Icons.house_siding,
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
                Icons.account_circle,
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
                Icons.notifications,
              ),
              title: Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.warning_amber_outlined,
              ),
              title: Text(
                "Alerts",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.help,
              ),
              title: Text(
                "Help",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
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
