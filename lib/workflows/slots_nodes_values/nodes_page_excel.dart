import 'package:flutter/material.dart';
import 'package:iot_project/workflows/slots_nodes_values/node_values_page_excel.dart';

import '../home/home_page.dart';

class NodesPageExcel extends StatefulWidget {
  final String slotName;
  final String slotID;
  final List<String> nodesList;

  NodesPageExcel(
      {required this.slotName, required this.slotID, required this.nodesList});

  @override
  State<NodesPageExcel> createState() => _NodesPageExcelState();
}

class _NodesPageExcelState extends State<NodesPageExcel> {
  List<Node> nodeList = [];

  Future<void> fetchSlots() async {
    nodeList = List.generate(
      widget.nodesList.length,
      (index) => Node(
        isActive: 1,
        nodeID: widget.nodesList[index],
      ),
    );
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
                Wrap(
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
                                    builder: (context) => NodeValuesPageExcel(
                                      nodeID: nodeList[index].nodeID,
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
