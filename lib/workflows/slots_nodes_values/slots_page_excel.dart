import 'package:flutter/material.dart';
import 'package:iot_project/workflows/slots_nodes_values/nodes_page_excel.dart';

import '../home/home_page.dart';

class SlotsPageExcel extends StatefulWidget {
  final String warehouseID;
  final String warehouseName;
  final Map<String, List<String>> slotNodesList;

  SlotsPageExcel(
      {required this.warehouseName,
      required this.warehouseID,
      required this.slotNodesList});

  @override
  State<SlotsPageExcel> createState() => _SlotsPageExcelState();
}

class _SlotsPageExcelState extends State<SlotsPageExcel> {
  List<Slot> slotList = [];

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

  void fetchSlots() {
    slotList = List.generate(
      widget.slotNodesList.length,
      (index) =>
          Slot(isActive: 1, slotID: widget.slotNodesList.keys.toList()[index]),
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
          widget.warehouseName,
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, top: 15),
            child: Text(
              "Slots",
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
                  children: List.generate(slotList.length, (index) {
                    return SizedBox(
                      width: 250,
                      height: 150,
                      child: CustomElevatedButtonWithIdAndStatus(
                        name: "Slot ${index + 1}",
                        id: slotList[index].slotID,
                        status: "Good",
                        onTap: slotList[index].isActive == 1
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NodesPageExcel(
                                      slotName: "Slot ${index + 1}",
                                      slotID: slotList[index].slotID,
                                      nodesList: widget.slotNodesList[
                                          slotList[index].slotID]!,
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

class Slot {
  final String slotID;
  final int isActive;
  Slot({required this.isActive, required this.slotID});
}
