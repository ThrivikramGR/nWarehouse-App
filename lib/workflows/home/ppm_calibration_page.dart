import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PPMCalibrationPage extends StatefulWidget {
  const PPMCalibrationPage({Key? key}) : super(key: key);

  @override
  State<PPMCalibrationPage> createState() => _PPMCalibrationPageState();
}

class _PPMCalibrationPageState extends State<PPMCalibrationPage> {
  bool isLoading = true;
  late Timer timer;
  //List<PPMData> ppmData = [];
  List ppmData = [];
  void fetchData() async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      Response response = await dio.get(
        "https://api.n-warehouse.com/api/viewdata/dashboarddata",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString("token")}",
          },
        ),
      );

      setState(() {
        ppmData = response.data["data"];
        isLoading = false;
      });

      //ppmData = PPMData.deserializeData(response.data["data"]);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PPM Calibration",
        ),
        actions: [
          IconButton(
            onPressed: () {
              timer.cancel();
              fetchData();
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              itemCount: ppmData.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Wrap(
                  children: List.generate(
                    ppmData[index].length,
                    (i) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ppmData[index].keys.toList()[i] + ": ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ppmData[index][ppmData[index].keys.toList()[i]]
                                  .toString() +
                              " | ",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 15,
              ),
            ),
    );
  }
}

// class PPMData {
//   final int? SNo;
//   final String? WarehoueID;
//   final String? SlotID;
//   final String? NodeID;
//   final String? TGS2620;
//   final String? TGS2602;
//   final String? TGS2600;
//   final String? CO2;
//   final String? Temperature;
//   final String? Humidity;
//   final String? TimeStamp;
//   PPMData(
//       {this.WarehoueID,
//       this.SlotID,
//       this.NodeID,
//       this.TGS2620,
//       this.TGS2602,
//       this.TGS2600,
//       this.CO2,
//       this.Temperature,
//       this.Humidity,
//       this.TimeStamp,
//       this.SNo});
//
//   static List<PPMData> deserializeData(List dataList) {
//     List<PPMData> deserializedData = [];
//     for (Map data in dataList) {
//       deserializedData.add(
//         PPMData(
//           SNo: data["SNo"],
//           WarehoueID: data["WarehouseID"],
//           SlotID: data["SlotID"],
//           NodeID: data["NodeID"],
//           TGS2620: data["TGS2620"],
//           TGS2602: data["TGS2602"],
//           TGS2600: data["TGS2600"],
//           CO2: data["CO2"],
//           Temperature: data["Temperature"],
//           Humidity: data["Humidity"],
//           TimeStamp: data["TimeStamp"],
//         ),
//       );
//     }
//     return deserializedData;
//   }
// }
