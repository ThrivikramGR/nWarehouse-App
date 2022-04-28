import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/services/color_config.dart';

class CustomScaffoldElements {
  static AppBar getAppBar(String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConfig.primaryGreen,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
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
          color: Colors.white,
        ),
      ),
      actions: [
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onSelected: (items) {
            switch (items) {
              case 0:
                //First item (settings) selected
                print("Settings Selected");
                break;
              case 1:
                //Second item (Help) selected
                print("Help Selected");
                break;
              default:
                print("Case not defined");
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Help",
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
