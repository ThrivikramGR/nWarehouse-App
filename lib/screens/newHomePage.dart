import 'package:flutter/material.dart';

class NewHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: getDrawerChildren(),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.blue,
            ),
          );
        }),
        centerTitle: true,
        title: Text(
          "Warehouse",
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
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Good Morning, Mr. John Doe",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Material(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 75,
                        child: Center(
                          child: Text(
                            "Alerts",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              5,
                            ),
                          ),
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 75,
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
                        ),
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              5,
                            ),
                          ),
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 75,
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 35,
                      mainAxisSpacing: 20,
                      children: getGridViewChildren(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getDrawerChildren() {
    return [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text(
          "Drawer Sample",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      ListTile(
        title: Text(
          "Option 1",
        ),
        onTap: () {},
      ),
      ListTile(
        title: Text(
          "Option 2",
        ),
        onTap: () {},
      ),
    ];
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

  List<Widget> getGridViewChildren() {
    List<GridViewChild> gridViewChildren = [
      GridViewChild(child: Text("Node 1"), backgroundColor: Colors.red),
      GridViewChild(child: Text("Node 2"), backgroundColor: Colors.green),
      GridViewChild(child: Text("Node 3"), backgroundColor: Colors.green),
      GridViewChild(child: Text("Node 4"), backgroundColor: Colors.green),
      GridViewChild(child: Text("Node 5"), backgroundColor: Colors.green),
      GridViewChild(child: Text("Node 6"), backgroundColor: Colors.green),
      GridViewChild(child: Text("Node 7"), backgroundColor: Colors.red),
      GridViewChild(child: Text("Node 8"), backgroundColor: Colors.orange),
    ];
    return List.generate(
      gridViewChildren.length,
      (index) {
        return GestureDetector(
          onTap: () {
            print("node clicked");
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
