import 'dart:io';

import 'package:flutter/material.dart';

class NodesScreen extends StatefulWidget {
  final String slotID;
  final String nodeTypeDisplayName;
  final String nodeType;

  NodesScreen(
      {required this.slotID,
      required this.nodeTypeDisplayName,
      required this.nodeType});

  @override
  State<NodesScreen> createState() => _NodesScreenState();
}

class _NodesScreenState extends State<NodesScreen> {
  bool nodesLoaded = false;

  List<GridViewNode> gridViewChildren = [];

  void getNodes() async {
    final queryParameters = {'SlotID': 'S100101', 'Type': 'F'};
    final uri = Uri.https('node-js-new.herokuapp.com',
        '/api/warehouses/slots/nodes', queryParameters);

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    // final response = await http.get(uri, headers: headers);

    await Future.delayed(
      Duration(
        seconds: 1,
      ),
    );

    // deserializeSlots(json.decode(response.body));
    setState(() {
      nodesLoaded = true;
    });
  }

  void deserializeSlots(List slotList) {
    for (int i = 0; i < slotList.length; i++) {
      gridViewChildren.add(
        GridViewNode(
          child: Text(
            slotList[i]['NodeID']!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          status: slotList[i]['NodeStatus']!,
        ),
      );
    }
  }

  @override
  void initState() {
    getNodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          widget.slotID + " - " + widget.nodeTypeDisplayName,
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
      body: nodesLoaded
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: getGridViewNodes(context),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  List<Widget> getGridViewNodes(BuildContext context) {
    List<GridViewNode> gridViewChildren = [
      GridViewNode(
          child: Text(
            "Node 1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          status: "good"),
      GridViewNode(
          child: Text(
            "Node 2",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          status: "bad"),
      GridViewNode(
          child: Text(
            "Node 3",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          status: "degraded"),
      GridViewNode(
          child: Text(
            "Node 4",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          status: "good"),
    ];

    return List.generate(
      gridViewChildren.length,
      (index) {
        return GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => SelectNodeTypeScreen(
            //       warehouseName: widget.warehouseName,
            //       slotName: "Slot 1",
            //     ),
            //   ),
            // );
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

class GridViewNode {
  late final Widget child;
  late final Color backgroundColor;
  late final String status;

  GridViewNode({required Widget child, required String status}) {
    this.child = child;
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
