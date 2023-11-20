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
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFFFF3CE),
      //   centerTitle: true,
      //   title: Text(
      //     widget.warehouseName,
      //     style: TextStyle(
      //       fontFamily: "NunitoSans",
      //       color: Color(0xFF323232),
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      //   iconTheme: IconThemeData(
      //     color: Color(0xFF323232),
      //   ),
      // ),
      body: ListView(
        children: [
          CustomHomeTopBanner(),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 20),
            child: Center(
              child: Text(
                widget.warehouseName + " - Slots",
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
                        isActive: true,
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
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Image.asset(
                    "assets/images/ccamp_logo.jpg",
                    height: 100,
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
