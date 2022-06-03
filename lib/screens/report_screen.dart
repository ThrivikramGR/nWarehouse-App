import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  final List details;

  ReportScreen(this.details);

  List<Widget> getListViewChildren() {
    List<Widget> children = [];
    for (Map item in details) {
      children.add(
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: deserializeMap(item),
            color: Colors.grey,
          ),
        ),
      );
    }
    return children;
  }

  Widget deserializeMap(Map map) {
    List<Widget> columnChildren = [];
    for (String key in map.keys) {
      columnChildren.add(
        Row(
          children: [
            Text("$key"),
            Text(
              "${map[key]}",
            ),
          ],
        ),
      );
    }
    return Column(
      children: columnChildren,
    );
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
      body: ListView(
        children: getListViewChildren(),
      ),
    );
  }
}
