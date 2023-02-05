import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iot_project/custom_widgets/scaffold_elements.dart';
import 'package:iot_project/ppm_calibration_page.dart';
import 'package:iot_project/screens/home/notifications_screen.dart';
import 'package:iot_project/screens/home/remoteControl_screen.dart';
import 'package:iot_project/screens/home/user_profile_screen.dart';
import 'package:iot_project/screens/warehouse_flow/warehouse_slots/slots_screen.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  final String? username;

  HomeScreen({this.username = "martin"});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool warehouseListLoaded = false;

  List warehouseList = [];

  void fetchWarehouseList() async {
    // var dio = Dio();
    // var response = await dio.get(
    //     'http://node-js-new.herokuapp.com/api/username?username=${widget.username}');
    // warehouseList = response.data['warehouses'];
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      warehouseListLoaded = true;
    });
  }

  SnackBar snackBar = SnackBar(
    content: Text(
      'Warehouse disabled by Owner',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
    backgroundColor: Colors.red,
  );

  List<Widget> getWarehouseGridViewChildren() {
    List<Widget> children = [
      CustomInkwellFilledContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Warehouse 1",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF323232),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WarehouseHomeScreen(
                warehouseName: "NW1001",
                username: widget.username!,
              ),
            ),
          );
        },
      ),
      CustomInkwellFilledContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Warehouse 2",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF323232),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WarehouseHomeScreen(
                warehouseName: "NW1001",
                username: widget.username!,
              ),
            ),
          );
        },
      ),
      CustomInkwellFilledContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Warehouse 3",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF323232),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WarehouseHomeScreen(
                warehouseName: "NW1001",
                username: widget.username!,
              ),
            ),
          );
        },
      ),
      CustomInkwellFilledContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Warehouse 4",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF323232),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WarehouseHomeScreen(
                warehouseName: "NW1001",
                username: widget.username!,
              ),
            ),
          );
        },
      ),
      CustomInkwellFilledContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Warehouse 5",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF323232),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WarehouseHomeScreen(
                warehouseName: "NW1001",
                username: widget.username!,
              ),
            ),
          );
        },
      ),
      CustomInkwellFilledContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Warehouse 6",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF323232),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WarehouseHomeScreen(
                warehouseName: "NW1001",
                username: widget.username!,
              ),
            ),
          );
        },
      ),
      // CustomInkwellFilledContainer(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         "Warehouse 7",
      //         style: TextStyle(
      //           fontFamily: "NunitoSans",
      //           fontSize: 20,
      //           fontWeight: FontWeight.w700,
      //           color: Color(0xFF323232),
      //         ),
      //       ),
      //     ],
      //   ),
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => WarehouseHomeScreen(
      //           warehouseName: "NW1001",
      //           username: widget.username!,
      //         ),
      //       ),
      //     );
      //   },
      // ),
      // GestureDetector(
      //   onTap: () {
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   },
      //   child: CustomInkwellFilledContainer(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           "Warehouse 2",
      //           style: TextStyle(
      //             fontFamily: "NunitoSans",
      //             fontSize: 20,
      //             fontWeight: FontWeight.w700,
      //             color: Color(0xFF323232),
      //           ),
      //         ),
      //       ],
      //     ),
      //     onPressed: null,
      //   ),
      // ),
      // GestureDetector(
      //   onTap: () {
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   },
      //   child: CustomInkwellFilledContainer(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           "Warehouse 3",
      //           style: TextStyle(
      //             fontFamily: "NunitoSans",
      //             fontSize: 20,
      //             fontWeight: FontWeight.w700,
      //             color: Color(0xFF323232),
      //           ),
      //         ),
      //       ],
      //     ),
      //     onPressed: null,
      //   ),
      // ),
    ];
    // for (int i = 0; i < warehouseList.length; i++) {
    //   //warehouse nullable
    //   if (warehouseList[i] != null) {
    //     children.add(
    //       CustomInkwellFilledContainer(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               "Warehouse ${i + 1}",
    //               style: TextStyle(
    //                 fontFamily: "NunitoSans",
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w700,
    //                 color: Color(0xFF323232),
    //               ),
    //             ),
    //             Text(
    //               warehouseList[i],
    //               style: TextStyle(
    //                 fontFamily: "NunitoSans",
    //                 color: Color(0xFF92A65F),
    //               ),
    //             ),
    //           ],
    //         ),
    //         onPressed: () {
    //           Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => WarehouseHomeScreen(
    //                 warehouseName: warehouseList[i],
    //                 username: widget.username!,
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     );
    //   }
    // }

    return children;
  }

  @override
  void initState() {
    fetchWarehouseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF92A65F),
      appBar: CustomScaffoldElements.getAppBar("nWarehouse", context),
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
                      "Manivannan",
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PPMCalibrationPage(),
                      ),
                    );
                  },
                  child: Text(
                    "PPM Calibration",
                  ),
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
                    SizedBox(
                      width: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RemoteControlScreen(),
                          ),
                        );
                      },
                      child: Hero(
                        tag: "remote",
                        child: Icon(
                          Icons.settings_remote_outlined,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                                  children: getWarehouseGridViewChildren(),
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
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/images/nw_bg.png",
                          scale: 1.5,
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

  Color color = Color(0xFFE5EAD9);
}

class CustomInkwellFilledContainer extends StatelessWidget {
  const CustomInkwellFilledContainer({
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        //primary: Color(0xFFDCDE9F),
        primary: Color(0xFFE5EAD9),
        onPrimary: Color(0xFF92A65F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          style: BorderStyle.solid,
          color: Color(0xFF92A65F),
          width: 1,
        ),

        elevation: 0,
      ),
      child: child,
    );
  }
}
