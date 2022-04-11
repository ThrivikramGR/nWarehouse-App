import 'package:flutter/material.dart';

class NodesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NWarehouse - Nodes",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20),
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Text(
              "Fixed Node",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox()
        ],
      ),
    );
  }
}
