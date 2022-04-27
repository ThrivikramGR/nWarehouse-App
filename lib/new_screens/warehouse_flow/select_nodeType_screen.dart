import 'package:flutter/material.dart';
import 'package:iot_project/custom_widgets/inkwell_container.dart';
import 'package:iot_project/services/color_config.dart';

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
        iconTheme: IconThemeData(
          color: ColorConfig.primaryBlue,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          warehouseName + " - " + slotID,
          style: TextStyle(
            color: ColorConfig.primaryBlue,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomInkwellContainer(
              height: 100,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NodesScreen(
                      nodeTypeDisplayName: 'Fixed Node',
                      slotID: slotID,
                      nodeType: 'F',
                    ),
                  ),
                );
              },
              splashColor: Colors.blue[200],
              backgroundColor: ColorConfig.backgroundLightBlue,
              child: Center(
                child: Text(
                  "Fixed Node",
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorConfig.primaryBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomInkwellContainer(
              height: 100,
              onPressed: () {},
              splashColor: Colors.blue[200],
              backgroundColor: ColorConfig.backgroundLightBlue,
              child: Center(
                child: Text(
                  "Mobile Node",
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorConfig.primaryBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomInkwellContainer(
              height: 100,
              onPressed: () {},
              splashColor: Colors.blue[200],
              backgroundColor: ColorConfig.backgroundLightBlue,
              child: Center(
                child: Text(
                  "Probe Node",
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorConfig.primaryBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
