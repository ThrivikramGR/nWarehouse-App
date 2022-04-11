import 'package:flutter/material.dart';
import 'package:iot_project/screens/home_screen_pages/profile_page.dart';
import 'package:iot_project/screens/home_screen_pages/warehouse_page.dart';

class HomeScreen extends StatefulWidget {
  final String? username;
  HomeScreen({required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navBarCurrentIndex = 0;
  late List<Widget> _pages = [
    WarehousePage(
      username: widget.username!,
    ),
    Center(
      child: Icon(
        Icons.water,
      ),
    ),
    ProfilePage(),
  ];

  List<BottomNavigationBarItem> navBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.house_siding),
      label: 'Warehouse',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sensors),
      label: 'Nodes',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_sharp),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "NWarehouse",
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navBarCurrentIndex,
          onTap: (index) {
            setState(() {
              _navBarCurrentIndex = index;
            });
          },
          items: navBarItems,
        ),
        body: _pages[_navBarCurrentIndex]);
  }
}
