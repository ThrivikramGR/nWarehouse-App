import 'package:flutter/material.dart';
import 'package:iot_project/custom_widgets/dropdown_button.dart';
import 'package:iot_project/custom_widgets/inkwell_container.dart';
import 'package:iot_project/services/color_config.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  HomeScreen({this.userName = "Guest"});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> dummyWarehouseList = [
    "Warehouse - NW1001",
    "Warehouse - NW1002",
    "Warehouse - NW1003",
    "Warehouse - NW1004",
  ];

  String dropdownValue = 'default';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Container(
        // width: MediaQuery.of(context).size.width,
        child: Drawer(
          backgroundColor: ColorConfig.backgroundLightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getDrawerChildren(),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.blue,
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "Select Warehouse",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.blue,
            ),
            onSelected: (items) {
              switch (items) {
                case 0:
                  //First item (settings) selected
                  print("Settings Selected");
                  break;
                case 1:
                  //Second item (Sign out) selected
                  print("Sign out Selected");
                  break;
                default:
                  print("Case not defined");
              }
            },
            itemBuilder: (context) {
              return getPopupMenuItems();
            },
          ),
        ],
      ),
      body: Column(
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
                          print(dropdownValue);
                        }
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => SlotScreen()),
                        // );
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
      ),
    );
  }

  List<Widget> getDrawerChildren() {
    return [
      SizedBox(
        height: 200,
        child: DrawerHeader(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          decoration: BoxDecoration(
            color: ColorConfig.primaryBlue,
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 45,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                widget.userName![0].toUpperCase() +
                    widget.userName!.substring(1),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.house_siding,
        ),
        title: Text(
          "Warehouse",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 17,
          ),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(
          Icons.account_circle,
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 17,
          ),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(
          Icons.notifications,
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 17,
          ),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(
          Icons.warning_amber_outlined,
        ),
        title: Text(
          "Alerts",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 17,
          ),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(
          Icons.help,
        ),
        title: Text(
          "Help",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 17,
          ),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.red,
        ),
        title: Text(
          "Logout",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 17,
          ),
        ),
        onTap: () {},
      ),
    ];
  }

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

  List<PopupMenuItem> getPopupMenuItems() {
    return [
      PopupMenuItem(
        value: 0,
        child: Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      PopupMenuItem(
        value: 1,
        child: Text(
          "Sign out",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    ];
  }
}
