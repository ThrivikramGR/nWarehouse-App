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
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          widget.warehouseName,
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF323232),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 30, top: 25),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
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
                        color: Color(0xFF323232),
                      ),
                      Text(
                        "Alerts",
                        style: TextStyle(
                            fontFamily: "NunitoSans",
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    //primary: Color(0xFFDCDE9F),
                    primary: Color(0xFFE5EAD9),
                    //onPrimary: Color(0xFF92A65F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Icon(
                        LineIcons.fileInvoice,
                        color: Color(0xFF323232),
                      ),
                      Text(
                        "Report",
                        style: TextStyle(
                            fontFamily: "NunitoSans",
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    //primary: Color(0xFFDCDE9F),
                    primary: Color(0xFFE5EAD9),
                    //onPrimary: Color(0xFF92A65F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                ElevatedButton(
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
                        color: Color(0xFF323232),
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontFamily: "NunitoSans",
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    //primary: Color(0xFFDCDE9F),
                    primary: Color(0xFFE5EAD9),
                    //onPrimary: Color(0xFF92A65F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE5EAD9),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Color(0xFF92A65F),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(12, 15, 12, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Slots",
                        style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 25,
                          color: Color(0xFF323232),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      slotsLoaded
                          ? GridView.count(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
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
          child: CustomStatusColorContainer(
              gridViewChildren: gridViewChildren, index: index),
        );
      },
    );
  }
}

class CustomStatusColorContainer extends StatelessWidget {
  const CustomStatusColorContainer(
      {required this.gridViewChildren, required this.index});

  final List<GridViewSlot> gridViewChildren;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
        color: Colors.white,
      ),
      child: Center(
        child: gridViewChildren[index].child,
      ),
    );
  }
}

class GridViewSlot {
  late final String slotID;
  late final Widget child;
  late final Color statusColor;
  late final String status;

  GridViewSlot({required String status, required String slotID}) {
    this.slotID = slotID;

    this.status = status;
    if (this.status.length < 4) {
      this.statusColor = Colors.yellow[600]!;
    } else if (this.status.toLowerCase().substring(0, 4) == "good") {
      this.statusColor = Colors.lightGreen;
    } else if (this.status.toLowerCase() == "degraded") {
      this.statusColor = Colors.red;
    } else {
      this.statusColor = Colors.yellow[600]!;
    }
    this.child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          slotID,
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: ColorConfig.primaryGreenAlt,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
            color: this.statusColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: 2,
          width: 25,
        ),
      ],
    );
  }
}
