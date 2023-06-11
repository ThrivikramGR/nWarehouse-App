import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../slots_nodes_values/slots_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Warehouse> warehouseList = [];

  void displaySnackBar(String message,
      {Color color = Colors.red, int durationInSeconds = 3}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: durationInSeconds),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> fetchWarehouses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await Dio().post(
        "https://api.n-warehouse.com/api/state/warehouseState",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString("token")}",
          },
        ),
      );
      if (response.statusCode != 200 || response.data["success"] != 1) {
        if (response.data["message"] == "Invalid Token...") {
          displaySnackBar("Session Expired!");
          prefs.clear();
          Navigator.pushNamedAndRemoveUntil(
            context,
            "login",
            (Route<dynamic> route) => false,
          );
        }
        //hardcode in case api fails
        warehouseList.addAll([
          Warehouse(isActive: 1, warehouseID: "NW1001"),
          Warehouse(isActive: 1, warehouseID: "NW1002"),
          Warehouse(isActive: 0, warehouseID: "NW1003"),
        ]);
        setState(() {
          isLoading = false;
        });
        return;
      }
      for (Map warehouse in response.data["data"]) {
        warehouseList.add(
          Warehouse(
            isActive: warehouse["isActive"],
            warehouseID: warehouse["idWarehouse"],
          ),
        );
      }
    } catch (e) {
      //hardcode in case api fails
      warehouseList.addAll([
        Warehouse(isActive: 1, warehouseID: "NW1001"),
        Warehouse(isActive: 1, warehouseID: "NW1002"),
        Warehouse(isActive: 1, warehouseID: "NW1003"),
      ]);
      warehouseList.add(
        Warehouse(
          isActive: 0,
          warehouseID: "NW1004",
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchWarehouses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomHomeTopBanner(),
          // SizedBox(
          //   height: 20,
          // ),
          // Wrap(
          //   alignment: WrapAlignment.center,
          //   spacing: 10,
          //   runSpacing: 10,
          //   children: [
          //     CustomElevatedButtonWithIcon(
          //       text: "Alerts",
          //       icon: Icons.notifications_none,
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => AlertsPage(),
          //           ),
          //         );
          //       },
          //     ),
          //     CustomElevatedButtonWithIcon(
          //       text: "Profile",
          //       icon: Icons.account_circle_outlined,
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => ProfilePage(),
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Wrap(
          //   alignment: WrapAlignment.center,
          //   spacing: 10,
          //   runSpacing: 10,
          //   children: [
          //     CustomElevatedButtonWithIcon(
          //       text: "PPM Calibration",
          //       icon: Icons.adjust_rounded,
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => PPMCalibrationPage(),
          //           ),
          //         );
          //       },
          //     ),
          //     CustomElevatedButtonWithIcon(
          //       text: "Robot Remote",
          //       icon: Icons.settings_remote_outlined,
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => RemoteControlPage(),
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
          //   child: Divider(),
          // ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Warehouses",
                    style: TextStyle(
                      fontFamily: "NunitoSans",
                      color: Color(0xFF323232),
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: GridView.count(
                            padding: EdgeInsets.only(bottom: 25),
                            childAspectRatio: 2.0,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2,
                            children:
                                List.generate(warehouseList.length, (index) {
                              return CustomElevatedButtonWithIdAndStatus(
                                name: "Warehouse ${index + 1}",
                                id: warehouseList[index].warehouseID,
                                status: "Good",
                                onTap: warehouseList[index].isActive == 1
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SlotsPage(
                                              warehouseName:
                                                  "Warehouse ${index + 1}",
                                              warehouseID: warehouseList[index]
                                                  .warehouseID,
                                            ),
                                          ),
                                        );
                                      }
                                    : null,
                              );
                            }),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.white,
                  child: Image.asset(
                    "assets/images/ccamp.png",
                    width: 200,
                  ),
                ),
                Image.asset(
                  "assets/images/tbi.png",
                  width: 300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      onSelected: (items) async {
        switch (items) {
          case 0:
            SharedPreferences.getInstance().then((value) {
              value.clear();
            });
            Navigator.pushNamedAndRemoveUntil(
              context,
              "login",
              (Route<dynamic> route) => false,
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
              "Logout",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ];
      },
    );
  }
}

class CustomElevatedButtonWithIdAndStatus extends StatelessWidget {
  const CustomElevatedButtonWithIdAndStatus({
    Key? key,
    required this.name,
    required this.id,
    required this.status,
    this.onTap,
  }) : super(key: key);
  final String name;
  final String id;
  final String status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Color(0xFF92A65F),
        side: BorderSide(
          style: BorderStyle.solid,
          color: Color(0xFF92A65F),
          width: 1,
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: onTap == null ? Colors.black38 : Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "ID",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: onTap == null ? Colors.black38 : Colors.white,
                    ),
                  ),
                  Text(
                    id,
                    style: TextStyle(
                      color: onTap == null ? Colors.black38 : Colors.white,
                    ),
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     Text(
              //       "Status",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black,
              //       ),
              //     ),
              //     Text(
              //       warehouseStatus,
              //       style: TextStyle(
              //         color: Colors.black,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Color(0xFFFFF3CE),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.grey[700],
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHomeTopBanner extends StatelessWidget {
  const CustomHomeTopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFF3CE),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/images/nw_logo.png",
              height: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "NWarehouse Pvt. Ltd.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "\"KAAPPAAN\"",
              style: TextStyle(
                color: Colors.green.shade800,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w800,
                letterSpacing: 3,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Supported by",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/birac_logo.png",
                  width: 200,
                ),
                Image.asset(
                  "assets/images/sas2.png",
                  width: 300,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomHomeTopBanner extends StatelessWidget {
//   const CustomHomeTopBanner({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       borderRadius: BorderRadius.vertical(
//         bottom: Radius.circular(30),
//       ),
//       elevation: 5,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFFFFF3CE),
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(30),
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 25,
//             ),
//             Text(
//               "NWarehouse Pvt. Ltd.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 50,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "Supported by",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 30,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Image.asset(
//               "assets/images/birac_logo.png",
//               width: 120,
//             ),
//             SizedBox(
//               height: 45,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Warehouse {
  final String warehouseID;
  final int isActive;
  Warehouse({required this.isActive, required this.warehouseID});
}
