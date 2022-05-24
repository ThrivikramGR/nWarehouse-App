import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../custom_widgets/inkwell_container.dart';

class WarehouseProfileScreen extends StatelessWidget {
  final String username;
  final String warehouseName;

  WarehouseProfileScreen({required this.username, required this.warehouseName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          "Warehouse Profile",
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "warehouseIcon",
                  child: Icon(
                    LineIcons.warehouse,
                    color: Color(0xFF323232),
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  warehouseName,
                  style: TextStyle(
                    fontFamily: "NunitoSans",
                    fontSize: 35,
                    color: Color(0xFF323232),
                  ),
                ),
                SizedBox(
                  height: 46,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
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
                                "8",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF323232),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Slots",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  color: Color(0xFF323232),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            LineIcons.warehouse,
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
                                "25",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF323232),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Nodes",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  color: Color(0xFF323232),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.sensors,
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
                                "TNJ",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF323232),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  color: Color(0xFF323232),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF323232),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
