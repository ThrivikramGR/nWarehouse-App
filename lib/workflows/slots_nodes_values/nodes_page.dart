import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iot_project/screens/node_screen2.dart';
import 'package:iot_project/screens/warehouse_flow/warehouse_slots/alerts_screen.dart';
import 'package:iot_project/screens/warehouse_flow/warehouse_slots/generate_report_screen.dart';
import 'package:iot_project/screens/warehouse_flow/warehouse_slots/warehouse_profile_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_page.dart';

class NodesPage extends StatefulWidget {
  final String slotName;
  final String slotID;

  NodesPage({required this.slotName, required this.slotID});

  @override
  State<NodesPage> createState() => _NodesPageState();
}

class _NodesPageState extends State<NodesPage> {
  List<Node> nodeList = [];
  bool isLoading = true;

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

  Future<void> fetchSlots() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await Dio().post(
        "https://api.n-warehouse.com/api/state/NodeStateBySlotId",
        data: {"id": widget.slotID},
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
        nodeList.addAll([
          Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "01"),
          Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "02"),
          Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "03"),
        ]);

        setState(() {
          isLoading = false;
        });
        return;
      }
      for (Map node in response.data["data"]) {
        nodeList.add(
          Node(
            isActive: node["isActive"],
            nodeID: node["NodeID"],
          ),
        );
      }
    } catch (e) {
      //hardcode in case api fails
      nodeList.addAll([
        Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "01"),
        Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "02"),
        Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "03"),
      ]);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.slotName,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, top: 15),
            child: Text(
              "Nodes",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 25,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
              padding: EdgeInsets.fromLTRB(18, 15, 18, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLoading
                      ? CircularProgressIndicator()
                      : GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: 1.6,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          crossAxisCount: 2,
                          children: List.generate(nodeList.length, (index) {
                            return CustomElevatedButtonWithIdAndStatus(
                              name: "Node ${index + 1}",
                              id: nodeList[index].nodeID,
                              status: "Good",
                              onTap: nodeList[index].isActive == 1
                                  ? () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => Container(),
                                      //   ),
                                      // );
                                    }
                                  : null,
                            );
                          }),
                          //children: getGridViewSlots(context),
                        ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      "assets/images/nw_bg.png",
                      scale: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Node {
  final String nodeID;
  final int isActive;
  Node({required this.isActive, required this.nodeID});
}
