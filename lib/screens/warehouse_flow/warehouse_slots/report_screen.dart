import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../../backup/dropdown_button.dart';

class ChooseDetailedReport extends StatefulWidget {
  @override
  State<ChooseDetailedReport> createState() => _ChooseDetailedReportState();
}

class _ChooseDetailedReportState extends State<ChooseDetailedReport> {
  String selectedNodeType = "F";
  String selectedSensorType = "G";

  int nodeTypeSelectedIndex = 0;

  Map<String, String> nodeTypeNameConversion = {
    "Fixed Node": "F",
    "Mobile Node": "M",
    "Probe Node": "P",
  };

  Map<String, String> sensorTypeNameConversion = {
    "Gas Sensor": "G",
    "CO2 Sensor": "C",
  };

  bool nodeListLoaded = true;
  bool slotListLoaded = true;
  String slotListSelectedItem = "SlotID";
  String nodeListSelectedItem = "NodeID";

  String startDate = DateTime.now().day.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().year.toString();
  String endDate = DateTime.now().day.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().year.toString();

  bool warehouseListLoaded = false;
  List warehouseList = [];
  String warehouseListSelectedItem = "default";

  void getWarehouseList() async {
    var dio = Dio();
    var response = await dio.get(
        'https://mobileapi.n-warehouse.com/api/detailedreport/warehouselist');
    warehouseList = response.data;

    setState(() {
      warehouseListLoaded = true;
    });
  }

  void getNodeItems() async {
    final queryParameters = {
      "TypeOfNode": selectedNodeType,
      'WarehouseID': warehouseListSelectedItem,
      "StartingDate": startDate,
      "EndingDate": endDate
    };
    var dio = Dio();
    var response = await dio.get('https://heroku-boy.herokuapp.com/typeofnodes',
        queryParameters: queryParameters);
    var arehouseList = response.data;

    setState(() {
      nodeListLoaded = true;
    });
  }

  List<DropdownMenuItem<String>> getNodeDropdownItems() {
    return [];
  }

  List<DropdownMenuItem<String>> getWarehouseDropdownItems() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(
          child: Text(
            "Select Warehouse",
          ),
          value: "default"),
    ];
    for (Map warehouse in warehouseList) {
      if (warehouse['WarehouseID'] != null)
        items.add(
          DropdownMenuItem(
            value: warehouse["WarehouseID"],
            child: Text(
              warehouse["WarehouseID"],
            ),
          ),
        );
    }
    return items;
  }

  @override
  void initState() {
    getWarehouseList();
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
          "Detailed Report",
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Warehouse ID",
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  warehouseListLoaded
                      ? Container()
                      : SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomDropdownButton(
                  value: warehouseListSelectedItem,
                  items:
                      warehouseListLoaded ? getWarehouseDropdownItems() : null,
                  onChanged: (value) {
                    setState(() {
                      warehouseListSelectedItem = value!;
                      slotsNodeAvailable = false;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              warehouseListSelectedItem != 'default'
                  ? Column(
                      children: [
                        Text(
                          "Dates",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'd MMM, yyyy',
                                  initialValue: DateTime.now().toString(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  dateLabelText: 'From',
                                  onChanged: (val) => startDate =
                                      val.substring(9) +
                                          "-" +
                                          val.substring(5, 7) +
                                          "-" +
                                          val.substring(0, 4),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'd MMM, yyyy',
                                  initialValue: DateTime.now().toString(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  dateLabelText: 'To',
                                  onChanged: (val) => endDate =
                                      val.substring(9) +
                                          "-" +
                                          val.substring(5, 7) +
                                          "-" +
                                          val.substring(0, 4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GroupButton(
                          options: GroupButtonOptions(),
                          onSelected: (sensorType, index, isSelected) {
                            selectedSensorType =
                                sensorTypeNameConversion[sensorType]!;
                            slotsNodeAvailable = false;
                          },
                          isRadio: true,
                          controller: GroupButtonController(
                            selectedIndex: 0,
                          ),
                          enableDeselect: false,
                          buttons: ["Gas Sensor", "CO2 Sensor"],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GroupButton(
                          options: GroupButtonOptions(),
                          onSelected: (nodeType, index, isSelected) {
                            setState(() {
                              selectedNodeType =
                                  nodeTypeNameConversion[nodeType]!;
                              nodeTypeSelectedIndex = index;
                              slotsNodeAvailable = false;
                            });
                          },
                          controller: GroupButtonController(
                            selectedIndex: nodeTypeSelectedIndex,
                          ),
                          isRadio: true,
                          enableDeselect: false,
                          buttons: ["Fixed Node", "Mobile Node", "Probe Node"],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              slotsNodeAvailable = true;
                            });
                          },
                          child: Text(
                            "Get Slots/Nodes",
                          ),
                        ),
                        slotsNodeAvailable
                            ? selectedNodeType == "F"
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      NodeTypeDropdowns(
                                        sensorType: selectedSensorType,
                                        nodeType: selectedNodeType,
                                        warehouseID: warehouseListSelectedItem,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      NodeTypeDropdowns(
                                        sensorType: selectedSensorType,
                                        nodeType: selectedNodeType,
                                        warehouseID: warehouseListSelectedItem,
                                      ),
                                    ],
                                  )
                                : NodeTypeDropdowns(
                                    sensorType: selectedSensorType,
                                    nodeType: selectedNodeType,
                                    warehouseID: warehouseListSelectedItem,
                                  )
                            : Container(),
                      ],
                    )
                  : Container(),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Generate Report",
            ),
          ),
        ],
      ),
    );
  }

  bool slotsNodeAvailable = false;
}

// class FixedNodeDropdowns extends StatefulWidget {
//   @override
//   State<FixedNodeDropdowns> createState() => _FixedNodeDropdownsState();
// }
//
// class _FixedNodeDropdownsState extends State<FixedNodeDropdowns> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class NodeTypeDropdowns extends StatefulWidget {
  // final DateTime startDate;
  // final DateTime endDate;
  final String warehouseID;
  final String sensorType;
  final String nodeType;
  NodeTypeDropdowns(
      {required this.warehouseID,
      required this.nodeType,
      required this.sensorType});

  @override
  State<NodeTypeDropdowns> createState() => _NodeTypeDropdownsState();
}

class _NodeTypeDropdownsState extends State<NodeTypeDropdowns> {
  String selectedNode = "default";
  bool isLoaded = false;
  String fetchedNode = "";

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(
          child: Text(
            "All Nodes",
          ),
          value: "default"),
    ];

    for (Map item in itemList) {
      if (item["SlotID"] != null)
        items.add(
          DropdownMenuItem(
            child: Text(
              item["SlotID"],
            ),
          ),
        );
    }
    return items;
  }

  List itemList = [];

  void fetchDropdownItems() async {
    setState(() {
      isLoaded = false;
    });

    Map<String, dynamic> params = {
      "typeofnode": "'${widget.nodeType}'",
      "sensortype": "'${widget.sensorType}'",
      "warehouseID": "'${widget.warehouseID}'",
      // "typeofnode": "'F'",
      // "sensortype": "'G'",
      // "warehouseID": "'NW1001'",
      "firstDate": "'07-05-2022'",
      "secondDate": "'31-05-2022'"
    };

    var dio = Dio();
    var response = await dio.get(
      // 'https://mobileapi.n-warehouse.com/api/detailedreport/typeofnode',
      "https://node-js-new.herokuapp.com/api/detailedreport/typeofnode?warehouseID='${widget.warehouseID}'&typeofnode='${widget.nodeType}'&sensortype='${widget.sensorType}'&firstDate='07-05-2022'&secondDate='31-05-2022'",
    );
    itemList = response.data;

    setState(() {
      isLoaded = true;
    });
    fetchedNode = widget.warehouseID;
  }

  @override
  void initState() {
    fetchDropdownItems();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Node",
            ),
            SizedBox(
              width: 15,
            ),
            isLoaded
                ? Container()
                : SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomDropdownButton(
            value: selectedNode,
            items: isLoaded ? getDropdownItems() : null,
            onChanged: (value) {
              setState(() {
                selectedNode = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
