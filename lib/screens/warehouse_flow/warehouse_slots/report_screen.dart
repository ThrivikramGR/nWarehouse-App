import 'package:flutter/material.dart';

import '../../../services/color_config.dart';

class ChooseDetailedReport extends StatefulWidget {
  @override
  State<ChooseDetailedReport> createState() => _ChooseDetailedReportState();
}

class _ChooseDetailedReportState extends State<ChooseDetailedReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: ColorConfig.primaryBlue,
          ),
          title: Text(
            "Detailed Report",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        body: Column(
          children: [
            Text(
              "NW-1001",
            ),
            Text(
              "Warehouse",
            ),
            //CustomDropdownButton(value: value, items: items, onChanged: onChanged)
          ],
        ));
  }
}
