import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/screens/home/popup_menu/add_user_screen.dart';
import 'package:iot_project/screens/home/popup_menu/help_page.dart';
import 'package:iot_project/services/color_config.dart';

import '../screens/home/popup_menu/add_warehouse_screen.dart';
import '../screens/warehouse_flow/warehouse_slots/generate_report_screen.dart';

class CustomScaffoldElements {
  static AppBar getAppBar(String title, BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xFF92A65F),
      leading: Builder(
        builder: (context) {
          return Transform.scale(
            //mirroring the icon
            scaleX: -1,
            child: IconButton(
              onPressed: () {
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
                            //todo: signout
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
                            //todo: signout
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
              icon: Icon(
                Icons.logout,
                color: Color(0xFF323232),
              ),
            ),
          );
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "NunitoSans",
          fontWeight: FontWeight.w700,
          color: Color(0xFF323232),
        ),
      ),
      actions: [
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: ColorConfig.pinkText,
          ),
          onSelected: (items) {
            switch (items) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpPage(),
                  ),
                );
                break;

              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserScreen(),
                  ),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddWarehouseScreen(),
                  ),
                );
                break;
              case 3:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChooseDetailedReport(),
                  ),
                );
                break;
              default:
                break;
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Help",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Add User",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "Add Warehouse",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Text(
                  "Detailed Report",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
