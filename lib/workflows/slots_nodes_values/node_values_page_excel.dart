import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NodeValuesPageExcel extends StatefulWidget {
  final String nodeID;

  NodeValuesPageExcel({required this.nodeID});

  @override
  State<NodeValuesPageExcel> createState() => _NodeValuesPageExcelState();
}

class _NodeValuesPageExcelState extends State<NodeValuesPageExcel> {
  bool loading = true;
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

  String nodeType = "fixed";

  List<GraphPoint> graph1Points = [];
  List<GraphPoint> graph2Points = [];
  List<GraphPoint> graph3Points = [];
  List<List> nodeValues = [];

  void fetchData() async {
    ByteData data = await rootBundle.load("excel_data/${widget.nodeID}.xlsx");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var decoder = SpreadsheetDecoder.decodeBytes(
      bytes,
    );
    var table = decoder.tables['Sheet1'];

    nodeValues.addAll(table!.rows.reversed
        .toList()
        .sublist(0, table.rows.length > 500 ? 500 : table.rows.length - 1));

    generateGraphPoints();
    setState(() {
      loading = false;
    });
  }

  void generateGraphPoints() {
    for (int i = 0; i < nodeValues.length; i++) {
      graph1Points.add(
        GraphPoint(
          i.toString(),
          nodeValues[i][3],
        ),
      );
      graph2Points.add(
        GraphPoint(
          i.toString(),
          nodeValues[i][4],
        ),
      );
      graph3Points.add(
        GraphPoint(
          i.toString(),
          nodeValues[i][5],
        ),
      );
    }
  }

  bool graphView = true;

  // Text getStatusText() {
  //   num avg = (double.parse(nodeValues[1][nodeTypeParamsMap[nodeType]![1]]) +
  //           double.parse(nodeValues[2][nodeTypeParamsMap[nodeType]![2]])) /
  //       2;
  //   if (avg > 2000) {
  //     return Text(
  //       "Take Action",
  //       style: TextStyle(
  //         fontSize: 22,
  //         color: Colors.red,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     );
  //   } else {
  //     return Text(
  //       "Good",
  //       style: TextStyle(
  //         fontSize: 22,
  //         color: Colors.green,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    if (widget.nodeID[3] == "C") nodeType = "CO2";
    fetchData();
    super.initState();
  }

  double getValue(int pos) {
    double sum = 0;
    for (int i = 0;
        i < (nodeValues.length > 30 ? 30 : nodeValues.length);
        i++) {
      sum += nodeValues[i][pos];
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
        child: loading
            ? Center(child: CircularProgressIndicator())
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
                                      widget.nodeID,
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
                                      "SV1",
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
                                      nodeValues[0][3].toString(),
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
                                      "SV2",
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
                                      nodeValues[0][4].toString(),
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
                                      "SV3",
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
                                      nodeValues[0][5].toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       "Status",
                                //       style: TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width:
                                //           MediaQuery.of(context).size.width / 4,
                                //     ),
                                //     getStatusText(),
                                //   ],
                                // ),
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
                                  value: getValue(3),
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
                                getValue(3).toStringAsFixed(0),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "SV1",
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
                                  value: getValue(4),
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
                                getValue(4).toStringAsFixed(0),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "SV2",
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
                                  value: getValue(5),
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
                                getValue(5).toStringAsFixed(0),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "SV3",
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
                                    text: "SV1",
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
                                    text: "SV2",
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
                                    text: "SV3",
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
                                                    nodeValues[index][3]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    "SV1",
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
                                                    nodeValues[index][4]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    "SV2",
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
                                                    nodeValues[index][5]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    "SV3",
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
