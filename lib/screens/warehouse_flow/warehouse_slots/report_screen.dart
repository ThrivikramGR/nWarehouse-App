import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../../backup/dropdown_button.dart';
import '../../../services/color_config.dart';

class ChooseDetailedReport extends StatefulWidget {
  @override
  State<ChooseDetailedReport> createState() => _ChooseDetailedReportState();
}

class _ChooseDetailedReportState extends State<ChooseDetailedReport> {
  String selectedNodeType = "E";

  Map<String, String> nodeTypeNameConversion = {
    "Fixed Node": "F",
    "Mobile Node": "M",
    "Probe Node": "P"
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
    var response =
        await dio.get('https://heroku-boy.herokuapp.com/WarehouseList');
    warehouseList = response.data;
    print(warehouseList);

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
    print(arehouseList);

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
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                        onChanged: (val) => startDate = val.substring(9) +
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
                        onChanged: (val) => endDate = val.substring(9) +
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
                onSelected: (value, index, isSelected) {
                  if (isSelected) {
                    nodeListLoaded = false;
                    slotListLoaded = false;
                    setState(() {
                      selectedNodeType = nodeTypeNameConversion[value]!;
                    });
                    if (selectedNodeType == "F") {
                      //getSlotItems();
                    } else {
                      getNodeItems();
                    }
                  } else {
                    setState(() {
                      selectedNodeType = "E";
                    });
                    slotListLoaded = true;
                    nodeListLoaded = true;
                  }
                },
                isRadio: true,
                enableDeselect: true,
                buttons: ["Fixed Node", "Mobile Node", "Probe Node"],
              ),
              selectedNodeType != "E"
                  ? selectedNodeType == "F"
                      ? Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomDropdownButton(
                                value: "0",
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Hi",
                                    ),
                                    value: "0",
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomDropdownButton(
                                value: "0",
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Hi",
                                    ),
                                    value: "0",
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomDropdownButton(
                            value: nodeListSelectedItem,
                            items:
                                nodeListLoaded ? getNodeDropdownItems() : null,
                            onChanged: (value) {
                              setState(() {
                                nodeListSelectedItem = value!;
                              });
                            },
                          ),
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
}
