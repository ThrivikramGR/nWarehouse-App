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
    nodeList.addAll([
      Node(
        isActive: 0,
        nodeID: "NWFG10010105",
      ),
      Node(
        isActive: 1,
        nodeID: "NWFG10010106",
      ),
      Node(
        isActive: 0,
        nodeID: "NWFG10010107",
      ),
      Node(
        isActive: 0,
        nodeID: "NWFG10010108",
      ),
      Node(
        isActive: 2,
        nodeID: "NWFG10010109",
      ),
      Node(
        isActive: 0,
        nodeID: "NWFG10010110",
      ),
      Node(
        isActive: 1,
        nodeID: "NWFG10010111",
      ),
      Node(
        isActive: 0,
        nodeID: "NWFG10010112",
      ),
    ]);
  }

  @override
  void initState() {
    fetchSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     widget.slotName,
      //     style: TextStyle(
      //       fontFamily: "NunitoSans",
      //       color: Color(0xFF323232),
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      //   iconTheme: IconThemeData(
      //     color: Color(0xFF323232),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.pushNamedAndRemoveUntil(
      //             context, "home", (Route<dynamic> route) => false);
      //       },
      //       icon: Icon(
      //         Icons.home,
      //       ),
      //     ),
      //   ],
      // ),
      body: ListView(
        children: [
          CustomHomeTopBanner(),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 20),
            child: Center(
              child: Text(
                "Warehouse ID# - " + "Slot ID#" + " - Node Details",
                style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 25,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w800,
                ),
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
            padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 25,
                  runSpacing: 25,
                  children: List.generate(nodeList.length, (index) {
                    return SizedBox(
                      width: 140,
                      height: 85,
                      child: CustomElevatedButtonWithIdAndStatusNode(
                        name: "Node Details",
                        id: nodeList[index].nodeID,
                        onTap: nodeList[index].isActive == 0
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NodeValuesPageExcel(
                                      nodeID: nodeList[index].nodeID,
                                    ),
                                  ),
                                );
                              },
                        isActive: (index == 8) ? false : true,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomElevatedButtonWithIdAndStatusNode extends StatelessWidget {
  const CustomElevatedButtonWithIdAndStatusNode({
    Key? key,
    required this.name,
    required this.isActive,
    required this.id,
    this.onTap,
  }) : super(key: key);
  final String name;
  final String id;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: isActive ? Colors.green.shade800 : Color(0xFFFFB935),
        foregroundColor: Color(0xFF92A65F),
        side: BorderSide(
          style: BorderStyle.solid,
          color: Color(0xFF92A65F),
          width: isActive ? 1 : 0,
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
              fontSize: 14,
              fontWeight: FontWeight.w800,
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
            ],
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
