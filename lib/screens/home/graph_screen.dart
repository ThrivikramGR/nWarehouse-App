import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<int> graph1 = [
    1654,
    1652,
    1720,
    1690,
    1725,
    1973,
    2111,
    2169,
    2390,
    2345,
    2906,
    2907,
    2806,
    2873,
    2907,
    2983,
    2969,
    3010,
    3009,
    3049
  ];
  List<int> graph2 = [
    1459,
    1420,
    1560,
    1649,
    1716,
    1823,
    2234,
    2354,
    2546,
    2697,
    2805,
    2867,
    2853,
    2869,
    2912,
    2934,
    2969,
    3008,
    3030,
    3096
  ];
  List<int> graph3 = [
    1100,
    1124,
    1245,
    1227,
    1289,
    1345,
    1578,
    1845,
    2004,
    2134,
    2212,
    2578,
    2756,
    2890,
    2945,
    2969,
    2993,
    3006,
    3019,
    3053
  ];
  List<GraphPoint> gp1 = [];
  List<GraphPoint> gp2 = [];

  List<GraphPoint> gp3 = [];

  void createGraphPoints() {
    for (int i = 0; i < graph1.length; i++) {
      gp1.add(GraphPoint(i.toString(), graph1[i]));
    }
    for (int i = 0; i < graph2.length; i++) {
      gp2.add(GraphPoint(i.toString(), graph2[i]));
    }
    for (int i = 0; i < graph3.length; i++) {
      gp3.add(GraphPoint(i.toString(), graph3[i]));
    }
  }

  @override
  void initState() {
    createGraphPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          "Slot 3",
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
        padding: EdgeInsets.only(top: 20),
        children: [
          SfCartesianChart(
            title: ChartTitle(
              text: "TGS2600",
            ),
            // Initialize category axis
            primaryXAxis: CategoryAxis(
              arrangeByIndex: true,
              isVisible: false,
            ),
            series: <LineSeries<GraphPoint, String>>[
              LineSeries<GraphPoint, String>(
                // Bind data source
                color: Colors.red,
                dataSource: gp1.reversed.toList(),
                xValueMapper: (GraphPoint sales, _) => sales.position,
                yValueMapper: (GraphPoint sales, _) => sales.value,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          SfCartesianChart(
            title: ChartTitle(
              text: "TGS2602",
            ),
            // Initialize category axis
            primaryXAxis: CategoryAxis(
              arrangeByIndex: true,
              isVisible: false,
            ),
            series: <LineSeries<GraphPoint, String>>[
              LineSeries<GraphPoint, String>(
                color: Colors.red,
                // Bind data source
                dataSource: gp2.reversed.toList(),
                xValueMapper: (GraphPoint sales, _) => sales.position,
                yValueMapper: (GraphPoint sales, _) => sales.value,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          SfCartesianChart(
            title: ChartTitle(
              text: "TGS2620",
            ),
            // Initialize category axis
            primaryXAxis: CategoryAxis(
              arrangeByIndex: true,
              isVisible: false,
            ),
            series: <LineSeries<GraphPoint, String>>[
              LineSeries<GraphPoint, String>(
                color: Colors.red,
                // Bind data source
                dataSource: gp3.reversed.toList(),
                xValueMapper: (GraphPoint sales, _) => sales.position,
                yValueMapper: (GraphPoint sales, _) => sales.value,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class GraphPoint {
  int value;
  String position;
  GraphPoint(this.position, this.value);
}
