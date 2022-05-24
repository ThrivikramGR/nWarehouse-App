import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../custom_widgets/inkwell_container.dart';

class WarehouseAlertsPage extends StatelessWidget {
  final String warehouseName;
  WarehouseAlertsPage({required this.warehouseName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          warehouseName + " - Alerts",
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
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: CustomInkwellContainer(
              height: 85,
              backgroundColor: Color(0xFFE5EAD9),
              splashColor: Color(0xFF92A65F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Node Alert",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF323232),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "15 mins ago",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            color: Color(0xFF323232),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      LineIcons.exclamation,
                      color: Color(0xFF323232),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: CustomInkwellContainer(
              height: 85,
              backgroundColor: Color(0xFFE5EAD9),
              splashColor: Color(0xFF92A65F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Node Degraded",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF323232),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "13 hours ago",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            color: Color(0xFF323232),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      LineIcons.exclamation,
                      color: Color(0xFF323232),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: CustomInkwellContainer(
              height: 85,
              backgroundColor: Color(0xFFE5EAD9),
              splashColor: Color(0xFF92A65F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Node degraded",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF323232),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "2 days ago",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            color: Color(0xFF323232),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      LineIcons.exclamation,
                      color: Color(0xFF323232),
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
