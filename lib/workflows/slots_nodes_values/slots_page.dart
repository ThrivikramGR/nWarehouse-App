import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/workflows/slots_nodes_values/nodes_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_page.dart';

class SlotsPage extends StatefulWidget {
  final String warehouseID;
  final String warehouseName;

  SlotsPage({required this.warehouseName, required this.warehouseID});

  @override
  State<SlotsPage> createState() => _SlotsPageState();
}

class _SlotsPageState extends State<SlotsPage> {
  List<Slot> slotList = [];
  bool isLoading = true;

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

  Future<void> fetchSlots() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await Dio().post(
        "https://api.n-warehouse.com/api/state/slotStateByWarehouseId",
        data: {"id": widget.warehouseID},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString("token")}",
          },
        ),
      );
      if (response.statusCode != 200 || response.data["success"] != 1) {
        if (response.data["message"] == "Invalid Token...") {
          displaySnackBar("Session Expired!");
          prefs.clear();
          Navigator.pushNamedAndRemoveUntil(
            context,
            "login",
            (Route<dynamic> route) => false,
          );
        }
        //hardcode in case api fails
        slotList.addAll([
          Slot(isActive: 1, slotID: widget.warehouseID + "01"),
          Slot(isActive: 1, slotID: widget.warehouseID + "02"),
          Slot(isActive: 0, slotID: widget.warehouseID + "03"),
          Slot(isActive: 0, slotID: widget.warehouseID + "04"),
          Slot(isActive: 0, slotID: widget.warehouseID + "05"),
        ]);
        setState(() {
          isLoading = false;
        });
        return;
      }
      for (Map slot in response.data["data"]) {
        slotList.add(
          Slot(
            isActive: slot["isActive"],
            slotID: slot["SlotID"],
          ),
        );
      }
      slotList.addAll([
        Slot(isActive: 0, slotID: widget.warehouseID + "03"),
        Slot(isActive: 0, slotID: widget.warehouseID + "04"),
        Slot(isActive: 0, slotID: widget.warehouseID + "05"),
      ]);
    } catch (e) {
      //hardcode in case api fails
      slotList.addAll([
        Slot(isActive: 1, slotID: widget.warehouseID + "01"),
        Slot(isActive: 1, slotID: widget.warehouseID + "02"),
        Slot(isActive: 0, slotID: widget.warehouseID + "03"),
        Slot(isActive: 0, slotID: widget.warehouseID + "04"),
        Slot(isActive: 0, slotID: widget.warehouseID + "05"),
      ]);
    }

    setState(() {
      isLoading = false;
    });
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: GridView.count(
                              childAspectRatio: 1.6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                              crossAxisCount: 2,
                              children: List.generate(slotList.length, (index) {
                                return CustomElevatedButtonWithIdAndStatus(
                                  name: "Slot ${index + 1}",
                                  id: slotList[index].slotID,
                                  status: "Good",
                                  onTap: slotList[index].isActive == 1
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NodesPage(
                                                slotName: "Slot ${index + 1}",
                                                slotID: slotList[index].slotID,
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                );
                              }),
                              //children: getGridViewSlots(context),
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
