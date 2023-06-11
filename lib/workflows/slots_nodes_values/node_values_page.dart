import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'hardcodedNodeValues.dart';

class NodeValuesPage extends StatefulWidget {
  final String nodeID;
  final String nodeName;

  NodeValuesPage({required this.nodeID, required this.nodeName});

  @override
  State<NodeValuesPage> createState() => _NodeValuesPageState();
}

class _NodeValuesPageState extends State<NodeValuesPage> {
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

  Map<String, List<String>> nodeTypeParamsMap = {
    "fixed": ["TGS2620", "TGS2602", "TGS2600"],
    "CO2": ["CO2", "Temperature", "Humidity"],
  };

  late Timer timer;

  String nodeType = "fixed";

  List<GraphPoint> graph1Points = [];
  List<GraphPoint> graph2Points = [];
  List<GraphPoint> graph3Points = [];
  List nodeValues = [];

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        Response response = await Dio().post(
          "https://api.n-warehouse.com/api/viewdata/databyNodeid",
          data: {"NodeID": widget.nodeID},
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${prefs.getString("token")}",
            },
          ),
        );
        if (response.statusCode != 200 || response.data["success"] != 1) {
          if (nodeValues.isEmpty) {
            if (response.data["message"] == "Invalid Token...") {
              displaySnackBar("Session Expired!");
              prefs.clear();
              Navigator.pushNamedAndRemoveUntil(
                context,
                "login",
                (Route<dynamic> route) => false,
              );
              //hardcode in case api fails
              nodeValues = hardcodedData;
              generateGraphPoints();
              setState(() {
                isLoading = false;
              });
              return;
            }
          }
        }

        nodeValues = response.data["data"];
      } catch (e) {
        if (nodeValues.isEmpty) {
          //hardcode in case api fails
          nodeValues = hardcodedData;
          generateGraphPoints();
          setState(() {
            isLoading = false;
          });
          return;
        }
      }
      graph1Points.clear();
      graph2Points.clear();
      graph3Points.clear();
      generateGraphPoints();
      setState(() {
        isLoading = false;
      });
    });
  }

  void generateGraphPoints() {
    for (int i = 0; i < nodeValues.length; i++) {
      graph1Points.add(
        GraphPoint(
          nodeValues[i]["TimeStamp"],
          double.parse(nodeValues[i][nodeTypeParamsMap[nodeType]![0]]),
        ),
      );
      graph2Points.add(
        GraphPoint(
          nodeValues[i]["TimeStamp"],
          double.parse(nodeValues[i][nodeTypeParamsMap[nodeType]![1]]),
        ),
      );
      graph3Points.add(
        GraphPoint(
          nodeValues[i]["TimeStamp"],
          double.parse(nodeValues[i][nodeTypeParamsMap[nodeType]![2]]),
        ),
      );
    }
  }

  bool graphView = true;

  Text getStatusText() {
    num avg = (double.parse(nodeValues[1][nodeTypeParamsMap[nodeType]![1]]) +
            double.parse(nodeValues[2][nodeTypeParamsMap[nodeType]![2]])) /
        2;
    if (avg > 2000) {
      return Text(
        "Take Action",
        style: TextStyle(
          fontSize: 22,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "Good",
        style: TextStyle(
          fontSize: 22,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.nodeID[3] == "C") nodeType = "CO2";
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  double getValue(int pos) {
    double sum = 0;
    for (int i = 0;
        i < (nodeValues.length > 30 ? 30 : nodeValues.length);
        i++) {
      sum += double.parse(nodeValues[i][nodeTypeParamsMap[nodeType]![pos]]);
    }
    return sum / (nodeValues.length > 30 ? 30 : nodeValues.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.nodeID,
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF323232),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "home", (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : nodeValues.isEmpty
                ? Center(
                    child: Text(
                      "No data available!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Recent Data",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Node ID",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                    Text(
                                      nodeValues[0]["NodeID"],
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      nodeTypeParamsMap[nodeType]![0],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                    Text(
                                      nodeValues[0]
                                          [nodeTypeParamsMap[nodeType]![0]],
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      nodeTypeParamsMap[nodeType]![1],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                    Text(
                                      nodeValues[0]
                                          [nodeTypeParamsMap[nodeType]![1]],
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      nodeTypeParamsMap[nodeType]![2],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                    Text(
                                      nodeValues[0]
                                          [nodeTypeParamsMap[nodeType]![2]],
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Timestamp",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  nodeValues[0]["TimeStamp"],
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Status",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                    getStatusText(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: AnimatedRadialGauge(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.elasticOut,
                                  value: getValue(0),
                                  progressBar: GaugeRoundedProgressBar(
                                    color: Colors.green.shade800,
                                  ),
                                  axis: GaugeAxis(
                                    min: 0,
                                    max: 3000,
                                    degrees: 180,
                                    style: const GaugeAxisStyle(
                                      thickness: 20,
                                      background: Color(0xFFDFE2EC),
                                    ),
                                    pointer: NeedlePointer(
                                      size: Size(16, 50),
                                      borderRadius: 16,
                                      backgroundColor: Color(0xFF193663),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                getValue(0).toStringAsFixed(0),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                nodeTypeParamsMap[nodeType]![0],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: AnimatedRadialGauge(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.elasticOut,
                                  value: getValue(1),
                                  progressBar: GaugeRoundedProgressBar(
                                    color: Colors.green.shade800,
                                  ),
                                  axis: GaugeAxis(
                                    min: 0,
                                    max: 3000,
                                    degrees: 180,
                                    style: const GaugeAxisStyle(
                                      thickness: 20,
                                      background: Color(0xFFDFE2EC),
                                    ),
                                    pointer: NeedlePointer(
                                      size: Size(16, 50),
                                      borderRadius: 16,
                                      backgroundColor: Color(0xFF193663),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                getValue(1).toStringAsFixed(0),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                nodeTypeParamsMap[nodeType]![1],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: AnimatedRadialGauge(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.elasticOut,
                                  value: getValue(2),
                                  progressBar: GaugeRoundedProgressBar(
                                    color: Colors.green.shade800,
                                  ),
                                  axis: GaugeAxis(
                                    min: 0,
                                    max: 3000,
                                    degrees: 180,
                                    style: const GaugeAxisStyle(
                                      thickness: 20,
                                      background: Color(0xFFDFE2EC),
                                    ),
                                    pointer: NeedlePointer(
                                      size: Size(16, 50),
                                      borderRadius: 16,
                                      backgroundColor: Color(0xFF193663),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                getValue(2).toStringAsFixed(0),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                nodeTypeParamsMap[nodeType]![2],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All Data",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  graphView = !graphView;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    graphView
                                        ? Icons.table_chart_outlined
                                        : Icons.show_chart,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    graphView ? "Data View" : "Graph View",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: graphView
                            ? [
                                SfCartesianChart(
                                  title: ChartTitle(
                                    text: nodeTypeParamsMap[nodeType]![0],
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    arrangeByIndex: true,
                                    isVisible: false,
                                  ),
                                  series: <LineSeries<GraphPoint, String>>[
                                    LineSeries<GraphPoint, String>(
                                      // markerSettings: MarkerSettings(
                                      //     isVisible: true, width: 4, height: 4),
                                      color: Colors.green,
                                      dataSource:
                                          graph1Points.reversed.toList(),
                                      xValueMapper: (GraphPoint point, _) =>
                                          point.x,
                                      yValueMapper: (GraphPoint point, _) =>
                                          point.y,
                                    ),
                                    // LineSeries<GraphPoint, String>(
                                    //   width: 1,
                                    //   color: Colors.red[400],
                                    //   // Bind data source
                                    //   dataSource: List.generate(
                                    //     nodeValues.length,
                                    //     (index) => GraphPoint("", 160),
                                    //   ),
                                    //   xValueMapper: (GraphPoint point, _) =>
                                    //       point.x,
                                    //   yValueMapper: (GraphPoint point, _) =>
                                    //       point.y,
                                    // ),
                                  ],
                                ),
                                SfCartesianChart(
                                  title: ChartTitle(
                                    text: nodeTypeParamsMap[nodeType]![1],
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    arrangeByIndex: true,
                                    isVisible: false,
                                  ),
                                  series: <LineSeries<GraphPoint, String>>[
                                    LineSeries<GraphPoint, String>(
                                      color: Colors.green,
                                      dataSource:
                                          graph2Points.reversed.toList(),
                                      xValueMapper: (GraphPoint point, _) =>
                                          point.x,
                                      yValueMapper: (GraphPoint point, _) =>
                                          point.y,
                                    ), // LineSeries<GraphPoint, String>(
                                    //   width: 1,
                                    //   color: Colors.red[400],
                                    //   // Bind data source
                                    //   dataSource: List.generate(
                                    //     nodeValues.length,
                                    //     (index) => GraphPoint("", 160),
                                    //   ),
                                    //   xValueMapper: (GraphPoint point, _) =>
                                    //       point.x,
                                    //   yValueMapper: (GraphPoint point, _) =>
                                    //       point.y,
                                    // ),
                                  ],
                                ),
                                SfCartesianChart(
                                  title: ChartTitle(
                                    text: nodeTypeParamsMap[nodeType]![2],
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    arrangeByIndex: true,
                                    isVisible: false,
                                  ),
                                  series: <LineSeries<GraphPoint, String>>[
                                    LineSeries<GraphPoint, String>(
                                      color: Colors.green,
                                      dataSource:
                                          graph3Points.reversed.toList(),
                                      xValueMapper: (GraphPoint point, _) =>
                                          point.x,
                                      yValueMapper: (GraphPoint point, _) =>
                                          point.y,
                                    ), // LineSeries<GraphPoint, String>(
                                    //   width: 1,
                                    //   color: Colors.red[400],
                                    //   // Bind data source
                                    //   dataSource: List.generate(
                                    //     nodeValues.length,
                                    //     (index) => GraphPoint("", 160),
                                    //   ),
                                    //   xValueMapper: (GraphPoint point, _) =>
                                    //       point.x,
                                    //   yValueMapper: (GraphPoint point, _) =>
                                    //       point.y,
                                    // ),
                                  ],
                                ),
                              ]
                            : List.generate(
                                nodeValues.length,
                                (index) => Column(
                                  children: [
                                    Material(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        tileColor: Color(0xFF0F7F2F9),
                                        style: ListTileStyle.list,
                                        // title: Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(bottom: 10),
                                        //   child: Row(
                                        //     children: [
                                        //       Text(
                                        //         "Timestamp:",
                                        //         style: TextStyle(
                                        //           fontWeight: FontWeight.bold,
                                        //           color: Colors.grey[800],
                                        //           fontSize: 17,
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         width: 5,
                                        //       ),
                                        //       Text(
                                        //         nodeValues[index]["TimeStamp"],
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    nodeValues[index][
                                                        nodeTypeParamsMap[
                                                            nodeType]![0]],
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    nodeTypeParamsMap[
                                                        nodeType]![0],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[800],
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    nodeValues[index][
                                                        nodeTypeParamsMap[
                                                            nodeType]![1]],
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    nodeTypeParamsMap[
                                                        nodeType]![1],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[800],
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    nodeValues[index][
                                                        nodeTypeParamsMap[
                                                            nodeType]![2]],
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    nodeTypeParamsMap[
                                                        nodeType]![2],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[800],
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class GraphPoint {
  final String x;
  final num y;
  GraphPoint(this.x, this.y);
}
