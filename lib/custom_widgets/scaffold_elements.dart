import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/services/color_config.dart';

class CustomScaffoldElements {
  static AppBar getAppBar(String title, BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xFFE8E6D1),
      leading: Builder(
        builder: (context) {
          return Transform.scale(
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
                break;
              case 1:
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
                  "Logout",
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
