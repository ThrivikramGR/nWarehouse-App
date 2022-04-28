import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:iot_project/new_screens/warehouse_flow/warehouse_home_screen.dart';

import '../../custom_widgets/dropdown_button.dart';
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
              color: ColorConfig.primaryGreenAlt,
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
                  color: ColorConfig.primaryGreenAlt,
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
          decoration: BoxDecoration(
            color: Color(0xFF06919B),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good day, ",
                    style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Hero(
                    tag: "username",
                    child: Text(
                      "${widget.username[0].toUpperCase() + widget.username.substring(1)}.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  "Select Warehouse",
                  style: TextStyle(
                    fontFamily: "NunitoSans",
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: CustomDropdownButton(
                  dropdownColor: ColorConfig.lightGreenBackground,
                  trailingIcon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ColorConfig.primaryGreenAlt,
                  ),
                  borderColor: ColorConfig.lightGreenBackground,
                  borderWidth: 1,
                  value: dropdownValue,
                  items: warehouseListLoaded ? getDropdownItems() : null,
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: warehouseListLoaded
                        ? 0
                        : MediaQuery.of(context).size.width / 3,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (dropdownValue != "default") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WarehouseHomeScreen(
                              warehouseName: dropdownValue,
                              username: widget.username,
                            ),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 12,
                      ),
                      child: warehouseListLoaded
                          ? Text(
                              "View Warehouse",
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                color: ColorConfig.primaryGreenAlt,
                                fontSize: 16,
                              ),
                            )
                          : SpinKitWave(
                              color: ColorConfig.primaryGreen,
                              size: 25,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 15,
        //     vertical: 15,
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Recently Viewed",
        //         style: TextStyle(
        //           fontFamily: "NunitoSans",
        //           fontWeight: FontWeight.bold,
        //           fontSize: 20,
        //         ),
        //       ),
        //       SizedBox(
        //         height: 15,
        //       ),
        //       CustomInkwellContainer(
        //         splashColor: Colors.blue[200],
        //         height: 60,
        //         onPressed: () {},
        //         backgroundColor: ColorConfig.lightGreenBackground,
        //         child: Center(
        //           child: Text(
        //             "Warehouse - NW1001",
        //             style: TextStyle(
        //               fontFamily: "NunitoSans",
        //               fontSize: 20,
        //               color: ColorConfig.primaryGreenAlt,
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       CustomInkwellContainer(
        //         splashColor: Colors.blue[200],
        //         height: 60,
        //         onPressed: () {},
        //         backgroundColor: ColorConfig.lightGreenBackground,
        //         child: Center(
        //           child: Text(
        //             "Warehouse - NW1002",
        //             style: TextStyle(
        //               fontFamily: "NunitoSans",
        //               fontSize: 20,
        //               color: ColorConfig.primaryGreenAlt,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
