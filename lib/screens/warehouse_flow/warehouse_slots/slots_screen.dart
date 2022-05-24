import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iot_project/screens/warehouse_flow/node_type_screen.dart';
import 'package:iot_project/screens/warehouse_flow/warehouse_slots/alerts_screen.dart';
import 'package:iot_project/screens/warehouse_flow/warehouse_slots/warehouse_profile_screen.dart';
import 'package:line_icons/line_icons.dart';

class WarehouseHomeScreen extends StatefulWidget {
  final String warehouseName;
  final String username;
  WarehouseHomeScreen({required this.warehouseName, required this.username});

  @override
  State<WarehouseHomeScreen> createState() => _WarehouseHomeScreenState();
}

class _WarehouseHomeScreenState extends State<WarehouseHomeScreen> {
  bool slotsLoaded = false;
  List<GridViewSlot> gridViewChildren = [];

  @override
  void initState() {
    getSlots();
    super.initState();
  }

  void getSlots() async {
    var dio = Dio();
    var response =
        await dio.get('http://node-js-new.herokuapp.com/api/warehouses/slots');
    deserializeSlots(response.data);
    setState(() {
      slotsLoaded = true;
    });
  }

  void deserializeSlots(List slotList) {
    for (int i = 0; i < slotList.length; i++) {
      gridViewChildren.add(
        GridViewSlot(
          slotID: slotList[i]['SlotID']!,
          status: slotList[i]['SlotStatus']!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF92A65F),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF92A65F),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WarehouseAlertsPage(
                              warehouseName: widget.warehouseName,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Icon(
                            LineIcons.bell,
                            color: Color(0xFF323232),
                          ),
                          Text(
                            "Alerts",
                            style: TextStyle(
                                fontFamily: "NunitoSans",
                                color: Color(0xFF323232),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        //primary: Color(0xFFDCDE9F),
                        primary: Color(0xFFE5EAD9),
                        //onPrimary: Color(0xFF92A65F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => ChooseDetailedReport(),
                        //   ),
                        // );
                      },
                      child: Column(
                        children: [
                          Icon(
                            LineIcons.fileInvoice,
                            color: Color(0xFF323232),
                          ),
                          Text(
                            "Report",
                            style: TextStyle(
                                fontFamily: "NunitoSans",
                                color: Color(0xFF323232),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        //primary: Color(0xFFDCDE9F),
                        primary: Color(0xFFE5EAD9),
                        //onPrimary: Color(0xFF92A65F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WarehouseProfileScreen(
                              username: widget.username,
                              warehouseName: widget.warehouseName,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Hero(
                            tag: "warehouseIcon",
                            child: Icon(
                              LineIcons.warehouse,
                              color: Color(0xFF323232),
                            ),
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                                fontFamily: "NunitoSans",
                                color: Color(0xFF323232),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        //primary: Color(0xFFDCDE9F),
                        primary: Color(0xFFE5EAD9),
                        //onPrimary: Color(0xFF92A65F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
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
          Expanded(
            child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  slotsLoaded
                      ? Expanded(
                          child: GridView.count(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: getGridViewSlots(context),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 3,
                          ),
                          child: Center(
                            child: SpinKitWave(
                              color: Color(0xFF92A65F),
                              size: 35.0,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getGridViewSlots(BuildContext context) {
    return List.generate(
      gridViewChildren.length,
      (index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SelectNodeTypeScreen(
                  warehouseName: widget.warehouseName,
                  slotID: gridViewChildren[index].slotID,
                ),
              ),
            );
          },
          child: CustomStatusColorContainer(
              gridViewChildren: gridViewChildren, index: index),
        );
      },
    );
  }
}

class CustomStatusColorContainer extends StatelessWidget {
  const CustomStatusColorContainer(
      {required this.gridViewChildren, required this.index});

  final List<GridViewSlot> gridViewChildren;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
        border: Border.all(
          width: 1,
          color: Color(0xFF92A65F),
        ),
        color: Color(0xFFE5EAD9),
      ),
      child: Center(
        child: gridViewChildren[index].child,
      ),
    );
  }
}

class GridViewSlot {
  late final String slotID;
  late final Widget child;
  late final Color statusColor;
  late final String status;

  GridViewSlot({required String status, required String slotID}) {
    this.slotID = slotID;

    this.status = status;
    if (this.status.length < 4) {
      this.statusColor = Colors.orange;
    } else if (this.status.toLowerCase().substring(0, 4) == "good") {
      this.statusColor = Colors.green;
    } else if (this.status.toLowerCase() == "degraded") {
      this.statusColor = Colors.red;
    } else {
      this.statusColor = Colors.orange;
    }
    this.child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          slotID,
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
            color: this.statusColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: 3,
          width: 25,
        ),
      ],
    );
  }
}
