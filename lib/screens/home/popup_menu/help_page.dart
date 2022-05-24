import 'package:flutter/material.dart';

import '../../../custom_widgets/inkwell_container.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          "Help",
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
                    Text(
                      "Terms of Service",
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF323232),
                      ),
                    ),
                    Icon(
                      Icons.format_align_left,
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
                    Text(
                      "Troubleshooting",
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF323232),
                      ),
                    ),
                    Icon(
                      Icons.warning_amber_rounded,
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
                    Text(
                      "Contact Admin",
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF323232),
                      ),
                    ),
                    Icon(
                      Icons.message,
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
