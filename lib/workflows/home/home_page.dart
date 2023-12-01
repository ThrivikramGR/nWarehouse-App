import 'package:flutter/material.dart';

import '../slots_nodes_values/slots_page_excel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Warehouse> warehouseList = [];

  void displaySnackBar(String message,
      {Color color = Colors.red, int durationInSeconds = 3}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: durationInSeconds),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void fetchWarehouses() {
    warehouseList.addAll([
      Warehouse(isActive: 1, warehouseID: "NW1001"),
      Warehouse(isActive: 0, warehouseID: "NW1002"),
      Warehouse(isActive: 0, warehouseID: "NW1003"),
      Warehouse(isActive: 0, warehouseID: "NW1004"),
    ]);
  }

  @override
  void initState() {
    fetchWarehouses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomHomeTopBanner(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width < 700 ? 20 : 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0,
                ),
                Text(
                  "Warehouse ID with Details",
                  style: TextStyle(
                    fontFamily: "NunitoSans",
                    color: Color(0xFF323232),
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Wrap(
                  spacing: 25,
                  runSpacing: 25,
                  children: List.generate(warehouseList.length, (index) {
                    return SizedBox(
                      width: 250,
                      height: 150,
                      child: CustomElevatedButtonWithIdAndStatus(
                        name: "Warehouse ${index + 1}",
                        id: warehouseList[index].warehouseID,
                        isActive:
                            warehouseList[index].isActive == 1 ? true : false,
                        onTap: warehouseList[index].isActive == 1
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SlotsPageExcel(
                                      warehouseName: "Warehouse ${index + 1}",
                                      warehouseID:
                                          warehouseList[index].warehouseID,
                                      slotNodesList: {
                                        "NW10010101": [
                                          "NWFG10010101",
                                          "NWFG10010102",
                                          "NWFG10010103",
                                          "NWFG10010104",
                                        ],
                                        "NW10010102": [
                                          "NWFG10010205",
                                          "NWFG10010206",
                                          "NWFG10010207",
                                          "NWFG10010212",
                                        ],
                                        "NW10010103": [
                                          "NWFG10010308",
                                          "NWFG10010309",
                                          "NWFG10010310",
                                          "NWFG10010311",
                                        ],
                                      },
                                    ),
                                  ),
                                );
                              }
                            : () {
                                displaySnackBar(
                                    "Not Authorized to access warehouse!");
                              },
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          indent: 25,
          thickness: 2,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "\"A Grain Conserved is as good as a Grain Created\"",
          style: TextStyle(
            color: Colors.green,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFF3CE),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text(
                "NWarehouse Pvt. Ltd., Plot No: 11,12 - MASS Nivas, 4th Street, Gandhi Salai,",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Trichy, Tamil Nadu, India",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "n-warehouse.com",
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("nwarehouse2020@gmail.com"),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "6380089868",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomElevatedButtonWithIdAndStatus extends StatelessWidget {
  const CustomElevatedButtonWithIdAndStatus({
    Key? key,
    required this.name,
    required this.isActive,
    required this.id,
    this.onTap,
  }) : super(key: key);
  final String name;
  final String id;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: isActive ? Colors.green.shade800 : Color(0xFFFFB935),
        foregroundColor: Color(0xFF92A65F),
        side: BorderSide(
          style: BorderStyle.solid,
          color: Color(0xFF92A65F),
          width: isActive ? 1 : 0,
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: onTap == null ? Colors.black38 : Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "ID",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: onTap == null ? Colors.black38 : Colors.white,
                    ),
                  ),
                  Text(
                    id,
                    style: TextStyle(
                      color: onTap == null ? Colors.black38 : Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomHomeTopBanner extends StatelessWidget {
  const CustomHomeTopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFF3CE),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/nw_logo.png",
              height: 70,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "NWarehouse Pvt. Ltd.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            Text(
              "Trichy, Tamil Nadu, India.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\"KAAPPAAN\"",
              style: TextStyle(
                //color: Colors.green.shade800,
                color: Colors.pink,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "IoT Device for Rapid Quality Assessment\nfor Food Grains in Godown",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class Warehouse {
  final String warehouseID;
  final int isActive;
  Warehouse({required this.isActive, required this.warehouseID});
}
