import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:iot_project/custom_widgets/scaffold_elements.dart';
import 'package:iot_project/new_screens/drawer_pages/notifications_page.dart';
import 'package:iot_project/new_screens/drawer_pages/userProfile_page.dart';
import 'package:iot_project/new_screens/warehouse_flow/warehouse_slots_screen.dart';
import 'package:line_icons/line_icons.dart';

class SelectWarehousePage extends StatefulWidget {
  final String? username;

  SelectWarehousePage({this.username = "martin"});
  @override
  State<SelectWarehousePage> createState() => _SelectWarehousePageState();
}

class _SelectWarehousePageState extends State<SelectWarehousePage> {
  bool warehouseListLoaded = false;

  List warehouseList = [];

  void getWarehouseList() async {
    final queryParameters = {'username': widget.username};
    final uri = Uri.https(
        'node-js-new.herokuapp.com', '/api/username', queryParameters);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final response = await http.get(uri, headers: headers);
    warehouseList = json.decode(response.body)['warehouses'];

    setState(() {
      warehouseListLoaded = true;
    });
  }

  @override
  void initState() {
    getWarehouseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF92A65F),
      appBar: CustomScaffoldElements.getAppBar("nWare", context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Good day, ",
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 22,
                        color: Color(0xFF323232),
                      ),
                    ),
                    Text(
                      "${widget.username![0].toUpperCase() + widget.username!.substring(1)}.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Color(0xFF323232),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationsPage()),
                        );
                      },
                      child: Icon(
                        LineIcons.bell,
                        color: Color(0xFF323232),
                      ),
                      style: ElevatedButton.styleFrom(
                        //primary: Color(0xFFDCDE9F),
                        primary: Color(0xFFE5EAD9),
                        //onPrimary: Color(0xFF92A65F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfilePage(
                              username: widget.username!,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: "userIcon",
                        child: Icon(
                          LineIcons.userCircle,
                          color: Color(0xFF323232),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        //primary: Color(0xFFDCDE9F),
                        //primary: Color(0xFFE6E3C0),
                        primary: Color(0xFFE5EAD9),
                        //onPrimary: Color(0xFF92A65F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Expanded(
            child: Material(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              elevation: 30,
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        " Warehouses",
                        style: TextStyle(
                          fontFamily: "NunitoSans",
                          color: Color(0xFF323232),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      warehouseListLoaded
                          ? GridView.count(
                              padding: EdgeInsets.only(top: 5, bottom: 20),
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 2,
                              crossAxisSpacing: 11,
                              mainAxisSpacing: 15,
                              children:
                                  List.generate(warehouseList.length, (index) {
                                if (warehouseList[index] != null) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WarehouseHomeScreen(
                                            warehouseName: warehouseList[index],
                                            username: widget.username!,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      //primary: Color(0xFFDCDE9F),
                                      primary: Color(0xFFE5EAD9),
                                      onPrimary: Color(0xFF92A65F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(radius),
                                      ),
                                      side: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Color(0xFF92A65F),
                                        width: 1,
                                      ),

                                      elevation: 0,
                                    ),
                                    child: Center(
                                      child: Text(
                                        warehouseList[index],
                                        style: textStyle,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Center(
                                child: SpinKitWave(
                                  color: Color(0xFF92A65F),
                                  size: 35.0,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double radius = 8;
  TextStyle textStyle = TextStyle(
    fontFamily: "NunitoSans",
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0xFF323232),
  );
  Color color = Color(0xFFE5EAD9);
}
