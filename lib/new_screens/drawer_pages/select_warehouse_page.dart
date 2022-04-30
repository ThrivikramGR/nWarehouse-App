import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iot_project/new_screens/drawer_pages/notifications_page.dart';
import 'package:iot_project/new_screens/drawer_pages/userProfile_page.dart';
import 'package:line_icons/line_icons.dart';

import '../../services/color_config.dart';

class SelectWarehousePage extends StatefulWidget {
  final String username;

  SelectWarehousePage({required this.username});
  @override
  State<SelectWarehousePage> createState() => _SelectWarehousePageState();
}

class _SelectWarehousePageState extends State<SelectWarehousePage> {
  String dropdownValue = 'default';

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem<String>(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Warehouse...",
            style: TextStyle(
              fontFamily: "NunitoSans",
              color: ColorConfig.pinkText,
              fontSize: 14,
            ),
          ),
        ),
        value: 'default',
      ),
    ];

    items.addAll(
      List.generate(
        warehouseList.length,
        (index) {
          return DropdownMenuItem<String>(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                warehouseList[index],
                style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 14,
                  color: ColorConfig.pinkText,
                ),
              ),
            ),
            value: warehouseList[index],
          );
        },
      ),
    );
    return items;
  }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    "${widget.username[0].toUpperCase() + widget.username.substring(1)}.",
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
                      primary: Color(0xFFFFFCF3),
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
                            username: widget.username,
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
                      primary: Color(0xFFFFFCF3),
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
          // SizedBox(
          //   height: 25,
          // ),
          // Center(
          //   child: Text(
          //     "Select Warehouse",
          //     style: TextStyle(
          //       fontFamily: "NunitoSans",
          //       fontSize: 20,
          //       color: ColorConfig.pinkText,
          //       fontWeight: FontWeight.normal,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 25,
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 0),
          //   child: CustomDropdownButton(
          //     fillColor: ColorConfig.pinkPrimary,
          //     dropdownColor: ColorConfig.pinkPrimary,
          //     trailingIcon: Icon(
          //       Icons.keyboard_arrow_down_sharp,
          //       color: ColorConfig.pinkText,
          //     ),
          //     borderColor: ColorConfig.pinkPrimary,
          //     borderWidth: 1,
          //     value: dropdownValue,
          //     items: warehouseListLoaded ? getDropdownItems() : null,
          //     onChanged: (value) {
          //       setState(() {
          //         dropdownValue = value!;
          //       });
          //     },
          //   ),
          // ),
          // SizedBox(
          //   height: 25,
          // ),
          // Center(
          //   child: ElevatedButton(
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(
          //         Colors.white,
          //       ),
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //       ),
          //     ),
          //     onPressed: () {
          //       if (dropdownValue != "default") {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => WarehouseHomeScreen(
          //               warehouseName: dropdownValue,
          //               username: widget.username,
          //             ),
          //           ),
          //         );
          //       }
          //     },
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 5,
          //         vertical: 12,
          //       ),
          //       child: warehouseListLoaded
          //           ? Text(
          //               "View Warehouse",
          //               style: TextStyle(
          //                 fontFamily: "NunitoSans",
          //                 color: ColorConfig.pinkText,
          //                 fontSize: 16,
          //               ),
          //             )
          //           : SpinKitWave(
          //               color: ColorConfig.primaryGreen,
          //               size: 25,
          //             ),
          //     ),
          //   ),
          // ),
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
                  color: Color(0xFFFFFCF3),
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
                    GridView.count(
                      padding: EdgeInsets.only(top: 5, bottom: 20),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 15,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            //primary: Color(0xFFDCDE9F),
                            primary: color,
                            //onPrimary: Color(0xFF92A65F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),

                            elevation: 1,
                          ),
                          child: Center(
                            child: Text(
                              "NW100101",
                              style: textStyle,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            //primary: Color(0xFFDCDE9F),
                            primary: color,
                            //onPrimary: Color(0xFF92A65F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),

                            elevation: 1,
                          ),
                          child: Center(
                            child: Text(
                              "NW100101",
                              style: textStyle,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            //primary: Color(0xFFDCDE9F),
                            primary: color,
                            //onPrimary: Color(0xFF92A65F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),

                            elevation: 1,
                          ),
                          child: Center(
                            child: Text(
                              "NW100101",
                              style: textStyle,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            //primary: Color(0xFFDCDE9F),
                            primary: color,
                            //onPrimary: Color(0xFF92A65F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),

                            elevation: 1,
                          ),
                          child: Center(
                            child: Text(
                              "NW100101",
                              style: textStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double radius = 10;
  TextStyle textStyle = TextStyle(
    fontFamily: "NunitoSans",
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0xFF323232),
  );
  Color color = Color(0xFFf0ecc7);
}
