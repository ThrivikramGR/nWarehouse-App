import 'package:flutter/material.dart';
import 'package:iot_project/custom_widgets/inkwell_container.dart';
import 'package:iot_project/new_screens/warehouse_flow/select_nodeType_screen.dart';
import 'package:iot_project/new_screens/warehouse_flow/warehouse_alerts_screen.dart';
import 'package:iot_project/new_screens/warehouse_flow/warehouse_profile_screen.dart';
import 'package:iot_project/services/color_config.dart';

class WarehouseHomeScreen extends StatelessWidget {
  final String warehouseName;
  final String username;
  WarehouseHomeScreen({required this.warehouseName, required this.username});

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
          warehouseName,
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  // color: ColorConfig.backgroundLightBlue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Good Day, ${username[0].toUpperCase() + username.substring(1)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomInkwellContainer(
                    child: Center(
                      child: Text(
                        "Alerts",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    height: 75,
                    backgroundColor: ColorConfig.primaryBlue,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WarehouseAlertsPage(
                            warehouseName: warehouseName,
                          ),
                        ),
                      );
                    },
                    splashColor: Colors.blue[200],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInkwellContainer(
                          backgroundColor: ColorConfig.primaryBlue,
                          splashColor: Colors.blue[200],
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              "Detailed Report",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: CustomInkwellContainer(
                          backgroundColor: ColorConfig.primaryBlue,
                          splashColor: Colors.blue[200],
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => WarehouseProfileScreen(
                                  username: username,
                                  warehouseName: warehouseName,
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              "Warehouse Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConfig.backgroundLightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Slots",
                          style: TextStyle(
                            fontSize: 19,
                            color: ColorConfig.primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GridView.count(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: getGridViewChildren(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getGridViewChildren(BuildContext context) {
    List<GridViewChild> gridViewChildren = [
      GridViewChild(
        child: Text(
          "Slot 1",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      GridViewChild(
        child: Text(
          "Slot 2",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      GridViewChild(
        child: Text(
          "Slot 3",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      GridViewChild(
        child: Text(
          "Slot 4",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      GridViewChild(
        child: Text(
          "Slot 5",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      GridViewChild(
        child: Text(
          "Slot 6",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      GridViewChild(
        child: Text(
          "Slot 7",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      GridViewChild(
        child: Text(
          "Slot 8",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
    ];
    return List.generate(
      gridViewChildren.length,
      (index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SelectNodeTypeScreen(
                  warehouseName: warehouseName,
                  slotName: "Slot 1",
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  5,
                ),
              ),
              color: gridViewChildren[index].backgroundColor,
            ),
            child: Center(
              child: gridViewChildren[index].child,
            ),
          ),
        );
      },
    );
  }
}

class GridViewChild {
  final Widget child;
  final Color backgroundColor;

  GridViewChild({required this.child, required this.backgroundColor});
}
