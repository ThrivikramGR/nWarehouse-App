import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iot_project/new_screens/warehouse_flow/select_nodeType_screen.dart';
import 'package:iot_project/new_screens/warehouse_flow/warehouse_alerts_screen.dart';
import 'package:iot_project/new_screens/warehouse_flow/warehouse_profile_screen.dart';
import 'package:iot_project/services/color_config.dart';
import 'package:line_icons/line_icons.dart';

class WarehouseHomeScreen extends StatefulWidget {
  final String warehouseName;
  final String username;
  WarehouseHomeScreen({required this.warehouseName, required this.username});

  @override
  State<WarehouseHomeScreen> createState() => _WarehouseHomeScreenState();
}

class _WarehouseHomeScreenState extends State<WarehouseHomeScreen> {
  bool slotsLoaded = false;
  List<GridViewSlot> gridViewChildren = [];

  @override
  void initState() {
    getSlots();
    super.initState();
  }

  void getSlots() async {
    final uri = Uri.https('node-js-new.herokuapp.com', '/api/warehouses/slots');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    deserializeSlots(json.decode(response.body));
    setState(() {
      slotsLoaded = true;
    });
  }

  void deserializeSlots(List slotList) {
    for (int i = 0; i < slotList.length; i++) {
      gridViewChildren.add(
        GridViewSlot(
          slotID: slotList[i]['SlotID']!,
          status: slotList[i]['SlotStatus']!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorConfig.primaryBlue,
        ),
        title: Text(
          widget.warehouseName,
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                color: Color(0xFF06919B),
                child: Column(
                  children: [],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WarehouseAlertsPage(
                            warehouseName: widget.warehouseName,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          LineIcons.bell,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Alerts",
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Icon(
                          LineIcons.fileInvoice,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Report",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WarehouseProfileScreen(
                            username: widget.username,
                            warehouseName: widget.warehouseName,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          LineIcons.warehouse,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Profile",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CustomInkwellContainer(
                  //   child: Center(
                  //     child: Text(
                  //       "Alerts",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 20,
                  //       ),
                  //     ),
                  //   ),
                  //   height: 75,
                  //   backgroundColor: ColorConfig.primaryBlue,
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => WarehouseAlertsPage(
                  //           warehouseName: widget.warehouseName,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   splashColor: Colors.blue[200],
                  // ),
                  // SizedBox(
                  //   height: 25,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: CustomInkwellContainer(
                  //         backgroundColor: ColorConfig.primaryBlue,
                  //         splashColor: Colors.blue[200],
                  //         onPressed: () {},
                  //         child: Center(
                  //           child: Text(
                  //             "Detailed Report",
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 18,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 25,
                  //     ),
                  //     Expanded(
                  //       child: CustomInkwellContainer(
                  //         backgroundColor: ColorConfig.primaryBlue,
                  //         splashColor: Colors.blue[200],
                  //         onPressed: () {
                  //           Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //               builder: (context) => WarehouseProfileScreen(
                  //                 username: widget.username,
                  //                 warehouseName: widget.warehouseName,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         child: Center(
                  //           child: Text(
                  //             "Warehouse Profile",
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 18,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConfig.backgroundLightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(12, 15, 12, 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Slots",
                          style: TextStyle(
                            fontSize: 19,
                            color: ColorConfig.primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        slotsLoaded
                            ? GridView.count(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                childAspectRatio: 2,
                                crossAxisSpacing: 13,
                                mainAxisSpacing: 15,
                                children: getGridViewSlots(context),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 3,
                                ),
                                child: CircularProgressIndicator(),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getGridViewSlots(BuildContext context) {
    return List.generate(
      gridViewChildren.length,
      (index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SelectNodeTypeScreen(
                  warehouseName: widget.warehouseName,
                  slotID: gridViewChildren[index].slotID,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  5,
                ),
              ),
              color: gridViewChildren[index].backgroundColor,
            ),
            child: Center(
              child: gridViewChildren[index].child,
            ),
          ),
        );
      },
    );
  }
}

class GridViewSlot {
  late final String slotID;
  late final Widget child;
  late final Color backgroundColor;
  late final String status;

  GridViewSlot({required String status, required String slotID}) {
    this.slotID = slotID;
    this.child = Text(
      slotID,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    );
    this.status = status;
    if (this.status.length < 4) {
      this.backgroundColor = Colors.orange;
    } else if (this.status.toLowerCase().substring(0, 4) == "good") {
      this.backgroundColor = Colors.green;
    } else if (this.status.toLowerCase() == "degraded") {
      this.backgroundColor = Colors.red;
    } else {
      this.backgroundColor = Colors.orange;
    }
  }
}
