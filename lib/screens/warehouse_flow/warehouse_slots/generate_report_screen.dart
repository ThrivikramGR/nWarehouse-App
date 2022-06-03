import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:iot_project/screens/report_screen.dart';

import '../../../backup/dropdown_button.dart';

class ChooseDetailedReport extends StatefulWidget {
  @override
  State<ChooseDetailedReport> createState() => _ChooseDetailedReportState();
}

class _ChooseDetailedReportState extends State<ChooseDetailedReport> {
  String selectedNodeType = "F";
  String selectedSensorType = "G";

  int nodeTypeSelectedIndex = 0;
  int sensorTypeSelectedIndex = 0;

  Map<String, String> nodeTypeNameConversion = {
    "Fixed Node": "F",
    "Mobile Node": "M",
    "Probe Node": "P",
  };

  Map<String, String> sensorTypeNameConversion = {
    "Gas Sensor": "G",
    "CO2 Sensor": "C",
  };

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

  String selectedFixedNodeSlot = "SlotID";
  String selectedNode = "NodeID";

  void getWarehouseList() async {
    var dio = Dio();
    var response = await dio.get(
        'https://mobileapi.n-warehouse.com/api/detailedreport/warehouselist');
    warehouseList = response.data;

    setState(() {
      warehouseListLoaded = true;
    });
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

  bool slotsNodeAvailable = false;

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
          "Generate Report",
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
                      slotChosen = false;
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
                                    onChanged: (val) {
                                      startDate = val.substring(8) +
                                          "-" +
                                          val.substring(5, 7) +
                                          "-" +
                                          val.substring(0, 4);
                                      setState(() {
                                        slotsNodeAvailable = false;
                                        slotChosen = false;
                                      });
                                    }),
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
                                  onChanged: (val) {
                                    endDate = val.substring(8) +
                                        "-" +
                                        val.substring(5, 7) +
                                        "-" +
                                        val.substring(0, 4);
                                    setState(() {
                                      slotsNodeAvailable = false;
                                      slotChosen = false;
                                    });
                                  },
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
                            setState(() {
                              selectedSensorType =
                                  sensorTypeNameConversion[sensorType]!;
                              sensorTypeSelectedIndex = index;
                              slotsNodeAvailable = false;
                              slotChosen = false;
                            });
                          },
                          isRadio: true,
                          controller: GroupButtonController(
                            selectedIndex: sensorTypeSelectedIndex,
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
                              slotChosen = false;
                            });
                          },
                          controller: GroupButtonController(
                            selectedIndex: nodeTypeSelectedIndex,
                          ),
                          isRadio: true,
                          enableDeselect: false,
                          buttons: ["Fixed Node", "Mobile Node", "Probe Node"],
                        ),
                        slotsNodeAvailable
                            ? selectedNodeType == "F"
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      NodeTypeDropdowns(
                                        callbackDropdownValue: (String value) {
                                          selectedFixedNodeSlot = value;
                                          setState(() {
                                            slotChosen = false;
                                          });
                                        },
                                        sensorType: selectedSensorType,
                                        nodeType: selectedNodeType,
                                        warehouseID: warehouseListSelectedItem,
                                        startDate: startDate,
                                        endDate: endDate,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      slotChosen
                                          ? FixedNodesNodeDropdown(
                                              callbackDropdownValue:
                                                  (String value) =>
                                                      selectedNode = value,
                                              sensorType: selectedSensorType,
                                              nodeType: selectedNodeType,
                                              warehouseID:
                                                  warehouseListSelectedItem,
                                              startDate: startDate,
                                              endDate: endDate,
                                              slotID: selectedFixedNodeSlot,
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  slotChosen = true;
                                                });
                                              },
                                              child: Text(
                                                "Get Slots/Nodes",
                                              ),
                                            ),
                                    ],
                                  )
                                : NodeTypeDropdowns(
                                    callbackDropdownValue: (String value) =>
                                        selectedNode = value,
                                    sensorType: selectedSensorType,
                                    nodeType: selectedNodeType,
                                    warehouseID: warehouseListSelectedItem,
                                    startDate: startDate,
                                    endDate: endDate,
                                  )
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    slotsNodeAvailable = true;
                                  });
                                },
                                child: Text(
                                  "Get Slots/Nodes",
                                ),
                              ),
                      ],
                    )
                  : Container(),
            ],
          ),
          ElevatedButton(
            onPressed: generateReport,
            child: Text(
              "Generate Report",
            ),
          ),
        ],
      ),
    );
  }

  void generateReport() async {
    var dio = Dio();
    var response = await dio.get(
        "https://node-js-new.herokuapp.com/api/detailedreport/generatereport?warehouseID='$warehouseListSelectedItem'&typeofnode='$selectedNodeType'&sensortype='${selectedSensorType}'&firstDate='07-05-2022'&secondDate='31-05-2022'&SlotID=${selectedFixedNodeSlot == "SlotID" ? "SlotID" : "'$selectedFixedNodeSlot'"}&NodeID=${selectedNode == "NodeID" ? "NodeID" : "'$selectedNode'"}");
    print(response.data);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ReportScreen(response.data)),
    );
  }

  bool slotChosen = false;
}

class FixedNodesNodeDropdown extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String warehouseID;
  final String sensorType;
  final String nodeType;
  final String slotID;
  final Function(String) callbackDropdownValue;
  FixedNodesNodeDropdown(
      {required this.warehouseID,
      required this.nodeType,
      required this.sensorType,
      required this.callbackDropdownValue,
      required this.startDate,
      required this.endDate,
      required this.slotID});

  @override
  State<FixedNodesNodeDropdown> createState() => _FixedNodesNodeDropdownState();
}

class _FixedNodesNodeDropdownState extends State<FixedNodesNodeDropdown> {
  String selectedNode = "NodeID";
  bool isLoaded = false;
  String fetchedNode = "";

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(
          child: Text(
            "All Nodes",
          ),
          value: "NodeID"),
      DropdownMenuItem(
          child: Text(
            "None",
          ),
          value: "None"),
    ];

    for (Map item in itemList) {
      if (item["NodeID"] != null)
        items.add(
          DropdownMenuItem(
            child: Text(
              item["NodeID"],
            ),
            value: item["NodeID"],
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

    var dio = Dio();
    var response = await dio.get(
      "https://node-js-new.herokuapp.com/api/detailedreport/fixednodes?warehouseID='${widget.warehouseID}'&sensortype='${widget.sensorType}'&firstDate='07-05-2022'&secondDate='31-05-2022'&SlotID=${widget.slotID == "SlotID" ? "SlotID" : "'${widget.slotID}'"}",
    );
    itemList = response.data;
    print(response.data);

    setState(() {
      isLoaded = true;
    });
    fetchedNode = widget.warehouseID;
  }

  void passTheData(String data) => widget.callbackDropdownValue(data);

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
                passTheData(value);
              });
            },
          ),
        ),
      ],
    );
  }
}

class NodeTypeDropdowns extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String warehouseID;
  final String sensorType;
  final String nodeType;

  final Function(String) callbackDropdownValue;
  NodeTypeDropdowns(
      {required this.warehouseID,
      required this.nodeType,
      required this.sensorType,
      required this.callbackDropdownValue,
      required this.startDate,
      required this.endDate});

  @override
  State<NodeTypeDropdowns> createState() => _NodeTypeDropdownsState();
}

class _NodeTypeDropdownsState extends State<NodeTypeDropdowns> {
  late String selectedNode;
  bool isLoaded = false;
  String fetchedNode = "";

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(
          child: Text(widget.nodeType == 'F' ? 'All Slots' : 'All Nodes'),
          value: widget.nodeType == 'F' ? 'SlotID' : 'NodeID'),
    ];

    for (Map item in itemList) {
      if (item[widget.nodeType == 'F' ? 'SlotID' : 'NodeID'] != null)
        items.add(
          DropdownMenuItem(
            child: Text(
              item[widget.nodeType == 'F' ? 'SlotID' : 'NodeID'],
            ),
            value: item[widget.nodeType == 'F' ? 'SlotID' : 'NodeID'],
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

    var dio = Dio();
    var response = await dio.get(
      "https://node-js-new.herokuapp.com/api/detailedreport/typeofnode?warehouseID='${widget.warehouseID}'&typeofnode='${widget.nodeType}'&sensortype='${widget.sensorType}'&firstDate='07-05-2022'&secondDate='31-05-2022'",
    );
    itemList = response.data;

    setState(() {
      isLoaded = true;
    });
    fetchedNode = widget.warehouseID;
  }

  void passTheData(String data) => widget.callbackDropdownValue(data);

  @override
  void initState() {
    selectedNode = widget.nodeType == 'F' ? 'SlotID' : 'NodeID';
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
              widget.nodeType == 'F' ? 'Select Slot' : 'Select Node',
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
            dropdownColor: Colors.blue,
            value: selectedNode,
            items: isLoaded ? getDropdownItems() : null,
            onChanged: (value) {
              setState(() {
                selectedNode = value!;
                passTheData(value);
              });
            },
          ),
        ),
      ],
    );
  }
}
