import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NodeValuesPage extends StatefulWidget {
  final String nodeID;
  final String nodeName;

  NodeValuesPage({required this.nodeID, required this.nodeName});

  @override
  State<NodeValuesPage> createState() => _NodeValuesPageState();
}

class _NodeValuesPageState extends State<NodeValuesPage> {
  bool isLoading = true;

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

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await Dio().post(
        "https://api.n-warehouse.com/api/viewdata/databyNodeid",
        data: {"NodeID": widget.nodeID},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString("token")}",
          },
        ),
      );
      if (response.statusCode != 200 || response.data["success"] != 1) {
        if (response.data["message"] == "Invalid Token...") {
          displaySnackBar("Session Expired!");
          prefs.clear();
          Navigator.pushNamedAndRemoveUntil(
            context,
            "login",
            (Route<dynamic> route) => false,
          );
        }
        //hardcode in case api fails
        //todo:
        setState(() {
          isLoading = false;
        });
        return;
      }
      //todo:actual
    } catch (e) {
      //hardcode in case api fails
      //todo:
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.nodeName,
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF323232),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popUntil(
                (route) => route.isFirst,
              );
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, top: 15),
            child: Text(
              "Node ID: ${widget.nodeID}",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 20,
                color: Color(0xFF323232),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
