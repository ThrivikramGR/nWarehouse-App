import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/custom_widgets/inkwell_container.dart';
import 'package:line_icons/line_icons.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF323232),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20),
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: CustomInkwellContainer(
              height: 85,
              backgroundColor: Color(0xFFE5EAD9),
              splashColor: Color(0xFF92A65F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Available!",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF323232),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "2 hours ago",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            color: Color(0xFF323232),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      LineIcons.bell,
                      color: Color(0xFF323232),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: CustomInkwellContainer(
              height: 85,
              backgroundColor: Color(0xFFE5EAD9),
              splashColor: Color(0xFF92A65F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Node Alert",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF323232),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "13 hours ago",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            color: Color(0xFF323232),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      LineIcons.exclamation,
                      color: Color(0xFF323232),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
