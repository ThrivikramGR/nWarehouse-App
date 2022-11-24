import 'package:flutter/material.dart';
import 'package:iot_project/screens/warehouse_flow/warehouse_slots/slots_screen.dart';

import 'home/graph_screen.dart';

class NodeScreen2 extends StatefulWidget {
  final Color color;
  final String slotID;
  NodeScreen2(this.color, this.slotID);

  @override
  State<NodeScreen2> createState() => _NodeScreen2State();
}

class _NodeScreen2State extends State<NodeScreen2> {
  bool slotsLoaded = false;
  List<GridViewSlot> gridViewChildren = [];

  @override
  void initState() {
    getSlots();
    super.initState();
  }

  void getSlots() async {
    // var dio = Dio();
    // var response =
    //     await dio.get('http://node-js-new.herokuapp.com/api/warehouses/slots');

    deserializeSlots([
      {
        "Max(TimeStamp)": "2022-04-29 13:18:50.738920",
        "SlotID": "NWFG1001${widget.slotID}01",
        "SlotStatus": widget.slotID == "03" ? "Degraded" : "Good",
      },
      {
        "Max(TimeStamp)": "2022-04-29 13:18:50.738920",
        "SlotID": "NWFG1001${widget.slotID}02",
        "SlotStatus": "Degraded",
      },
      {
        "Max(TimeStamp)": "2022-04-29 13:18:50.738920",
        "SlotID": "NWFG1001${widget.slotID}03",
        "SlotStatus": widget.slotID == "03" ? "Degraded" : "Good",
      },
      {
        "Max(TimeStamp)": "2022-04-29 13:18:50.738920",
        "SlotID": "NWFG1001${widget.slotID}04",
        "SlotStatus": widget.slotID == "03" ? "Degraded" : "Good",
      },
      {
        "Max(TimeStamp)": "2022-04-29 13:18:50.738920",
        "SlotID": "NWFG1001${widget.slotID}05",
        "SlotStatus": widget.slotID == "03" ? "Degraded" : "Good",
      },
      {
        "Max(TimeStamp)": "2022-04-29 13:18:50.738920",
        "SlotID": "NWFG1001${widget.slotID}06",
        "SlotStatus": widget.slotID == "03" ? "Degraded" : "Good",
      },
    ]);

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
          "Slot - Nodes",
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
          Padding(
            padding: EdgeInsets.only(left: 18, top: 15),
            child: Text(
              "Nodes",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GridView.count(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: getGridViewSlots(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      "assets/images/nw_bg.png",
                      scale: 1.5,
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
    List<Widget> children = [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  GraphScreen(widget.color, gridViewChildren[0].slotID),
            ),
          );
        },
        child: CustomStatusColorContainer(
          gridViewChildren: gridViewChildren,
          index: 0,
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  GraphScreen(widget.color, gridViewChildren[1].slotID),
            ),
          );
        },
        child: CustomStatusColorContainer(
          gridViewChildren: gridViewChildren,
          index: 1,
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  GraphScreen(widget.color, gridViewChildren[1].slotID),
            ),
          );
        },
        child: CustomStatusColorContainer(
          gridViewChildren: gridViewChildren,
          index: 2,
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  GraphScreen(widget.color, gridViewChildren[1].slotID),
            ),
          );
        },
        child: CustomStatusColorContainer(
          gridViewChildren: gridViewChildren,
          index: 3,
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  GraphScreen(widget.color, gridViewChildren[1].slotID),
            ),
          );
        },
        child: CustomStatusColorContainer(
          gridViewChildren: gridViewChildren,
          index: 4,
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  GraphScreen(widget.color, gridViewChildren[1].slotID),
            ),
          );
        },
        child: CustomStatusColorContainer(
          gridViewChildren: gridViewChildren,
          index: 5,
        ),
      ),
    ];

    return children;
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
