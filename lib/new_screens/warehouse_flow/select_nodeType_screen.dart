import 'package:flutter/material.dart';
import 'package:iot_project/custom_widgets/inkwell_container.dart';

import 'nodes_screen.dart';

class SelectNodeTypeScreen extends StatelessWidget {
  final String warehouseName;
  final String slotID;

  SelectNodeTypeScreen({required this.warehouseName, required this.slotID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          slotID + " - Node Type",
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: CustomInkwellContainer(
              height: 85,
              backgroundColor: Color(0xFFE5EAD9),
              splashColor: Color(0xFF92A65F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Center(
                  child: Text(
                    "Fixed Node",
                    style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF323232),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NodesScreen(
                      nodeTypeDisplayName: 'Fixed Nodes',
                      slotID: slotID,
                      nodeType: 'F',
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: CustomInkwellContainer(
              height: 85,
              backgroundColor: Color(0xFFE5EAD9),
              splashColor: Color(0xFF92A65F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Center(
                  child: Text(
                    "Mobile Node",
                    style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF323232),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NodesScreen(
                      nodeTypeDisplayName: 'Mobile Nodes',
                      slotID: slotID,
                      nodeType: 'M',
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: CustomInkwellContainer(
              height: 85,
              backgroundColor: Color(0xFFE5EAD9),
              splashColor: Color(0xFF92A65F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Center(
                  child: Text(
                    "Probe Node",
                    style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF323232),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NodesScreen(
                      nodeTypeDisplayName: 'Probe Nodes',
                      slotID: slotID,
                      nodeType: 'P',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
