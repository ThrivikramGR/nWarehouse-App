import 'package:flutter/material.dart';
import 'package:iot_project/new_screens/warehouseHomePage.dart';

import '../../custom_widgets/dropdown_button.dart';
import '../../custom_widgets/inkwell_container.dart';
import '../../services/color_config.dart';

class SelectWarehousePage extends StatefulWidget {
  final String username;
  SelectWarehousePage({required this.username});
  @override
  State<SelectWarehousePage> createState() => _SelectWarehousePageState();
}

class _SelectWarehousePageState extends State<SelectWarehousePage> {
  List<String> dummyWarehouseList = [
    "Warehouse - NW1001",
    "Warehouse - NW1002",
    "Warehouse - NW1003",
    "Warehouse - NW1004",
  ];
  String dropdownValue = 'default';

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem<String>(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Choose Warehouse",
            style: TextStyle(
              color: ColorConfig.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        value: 'default',
      ),
    ];

    items.addAll(
      List.generate(
        dummyWarehouseList.length,
        (index) {
          return DropdownMenuItem<String>(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                dummyWarehouseList[index],
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConfig.primaryBlue,
                ),
              ),
            ),
            value: dummyWarehouseList[index],
          );
        },
      ),
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CustomDropdownButton(
                  dropdownColor: ColorConfig.backgroundLightBlue,
                  trailingIcon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ColorConfig.primaryBlue,
                  ),
                  borderColor: ColorConfig.primaryBlue,
                  borderWidth: 1,
                  value: dropdownValue,
                  items: getDropdownItems(),
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 65,
                ),
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (dropdownValue != "default") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WarehouseHomePage(
                              warehouseName: dropdownValue,
                              username: widget.username,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "View Warehouse",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  "Recently Viewed",
                  style: TextStyle(
                    color: ColorConfig.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: CustomInkwellContainer(
                  splashColor: Colors.blue[200],
                  height: 100,
                  onPressed: () {},
                  backgroundColor: ColorConfig.backgroundLightBlue,
                  child: Center(
                    child: Text(
                      "Warehouse - NW1001",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorConfig.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: CustomInkwellContainer(
                  splashColor: Colors.blue[200],
                  height: 100,
                  onPressed: () {},
                  backgroundColor: ColorConfig.backgroundLightBlue,
                  child: Center(
                    child: Text(
                      "Warehouse - NW1002",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorConfig.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
