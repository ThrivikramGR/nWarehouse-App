import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/workflows/slots_nodes_values/node_values_page.dart';
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
      nodeList.addAll([
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "04"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "05"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "06"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "07"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "08"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "09"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "10"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "11"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "12"),
      ]);
    } catch (e) {
      //hardcode in case api fails
      nodeList.addAll([
        Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "01"),
        Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "02"),
        Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "03"),
        Node(isActive: 1, nodeID: "NWFG" + widget.slotID.substring(2) + "04"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "05"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "06"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "07"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "08"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "09"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "10"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "11"),
        Node(isActive: 0, nodeID: "NWFG" + widget.slotID.substring(2) + "12"),
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "home", (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: ListView(
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
          Container(
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
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        children: List.generate(nodeList.length, (index) {
                          return SizedBox(
                            width: 250,
                            height: 150,
                            child: CustomElevatedButtonWithIdAndStatus(
                              name: "Node ${index + 1}",
                              id: nodeList[index].nodeID,
                              status: "Good",
                              onTap: nodeList[index].isActive == 1
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NodeValuesPage(
                                            nodeID: nodeList[index].nodeID,
                                            nodeName: "Node ${index + 1}",
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                            ),
                          );
                        }),
                      ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 50),
                  child: Image.asset(
                    "assets/images/nw_bg.png",
                    scale: 1.5,
                  ),
                ),
              ],
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
