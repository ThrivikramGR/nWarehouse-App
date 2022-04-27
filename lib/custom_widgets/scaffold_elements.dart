import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScaffoldElements {
  // static Drawer getDrawer(String userName, BuildContext context) {
  //   return Drawer(
  //     backgroundColor: ColorConfig.backgroundLightBlue,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         SizedBox(
  //           height: 200,
  //           child: DrawerHeader(
  //             padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
  //             decoration: BoxDecoration(
  //               color: ColorConfig.primaryBlue,
  //             ),
  //             child: Row(
  //               children: [
  //                 Icon(
  //                   Icons.account_circle,
  //                   color: Colors.white,
  //                   size: 45,
  //                 ),
  //                 SizedBox(
  //                   width: 15,
  //                 ),
  //                 Text(
  //                   userName[0].toUpperCase() + userName.substring(1),
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 30,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         ListTile(
  //           leading: Icon(
  //             Icons.house_siding,
  //           ),
  //           title: Text(
  //             "Warehouse",
  //             style: TextStyle(
  //               color: Colors.grey[700],
  //               fontSize: 17,
  //             ),
  //           ),
  //           onTap: () {},
  //         ),
  //         ListTile(
  //           leading: Icon(
  //             Icons.account_circle,
  //           ),
  //           title: Text(
  //             "Profile",
  //             style: TextStyle(
  //               color: Colors.grey[700],
  //               fontSize: 17,
  //             ),
  //           ),
  //           onTap: () {
  //             Navigator.popAndPushNamed(context, 'profile');
  //
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //     builder: (context) => ProfileScreen(),
  //             //   ),
  //             // );
  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(
  //             Icons.notifications,
  //           ),
  //           title: Text(
  //             "Notifications",
  //             style: TextStyle(
  //               color: Colors.grey[700],
  //               fontSize: 17,
  //             ),
  //           ),
  //           onTap: () {},
  //         ),
  //         ListTile(
  //           leading: Icon(
  //             Icons.warning_amber_outlined,
  //           ),
  //           title: Text(
  //             "Alerts",
  //             style: TextStyle(
  //               color: Colors.grey[700],
  //               fontSize: 17,
  //             ),
  //           ),
  //           onTap: () {},
  //         ),
  //         ListTile(
  //           leading: Icon(
  //             Icons.help,
  //           ),
  //           title: Text(
  //             "Help",
  //             style: TextStyle(
  //               color: Colors.grey[700],
  //               fontSize: 17,
  //             ),
  //           ),
  //           onTap: () {},
  //         ),
  //         ListTile(
  //           leading: Icon(
  //             Icons.logout,
  //             color: Colors.red,
  //           ),
  //           title: Text(
  //             "Logout",
  //             style: TextStyle(
  //               color: Colors.grey[700],
  //               fontSize: 17,
  //             ),
  //           ),
  //           onTap: () {
  //             if (Platform.isAndroid) {
  //               showDialog(
  //                 context: context,
  //                 builder: (_) => AlertDialog(
  //                   title: const Text("Logout"),
  //                   content: Text(
  //                     "Confirm logout?",
  //                   ),
  //                   actions: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: const Text("Cancel"),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         FirebaseAuth _auth = FirebaseAuth.instance;
  //                         _auth.signOut();
  //                         Navigator.pushNamedAndRemoveUntil(
  //                             context, "/", (Route<dynamic> route) => false);
  //                       },
  //                       child: const Text("Logout"),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             } else {
  //               showCupertinoDialog(
  //                 context: context,
  //                 builder: (_) => CupertinoAlertDialog(
  //                   title: const Text("Logout"),
  //                   content: Text(
  //                     "Confirm logout?",
  //                   ),
  //                   actions: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: const Text("Cancel"),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         FirebaseAuth _auth = FirebaseAuth.instance;
  //                         _auth.signOut();
  //                         Navigator.pushNamedAndRemoveUntil(
  //                             context, "/", (Route<dynamic> route) => false);
  //                       },
  //                       child: const Text("Logout"),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  static AppBar getAppBar(String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xFF06919B),
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
