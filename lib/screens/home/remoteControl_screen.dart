import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class RemoteControlScreen extends StatefulWidget {
  @override
  State<RemoteControlScreen> createState() => _RemoteControlScreenState();
}

class _RemoteControlScreenState extends State<RemoteControlScreen> {
  BleConState bleState = BleConState.disconnected;

  void connectBLE() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    while (true) {
      if (await flutterBlue.isOn) {
        setState(() {
          bleState = BleConState.connecting;
        });
      } else {
        setState(() {
          bleState = BleConState.disconnected;
        });
      }
      await Future.delayed(Duration(seconds: 2));
    }
  }

  @override
  void initState() {
    connectBLE();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          "Remote Control",
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
              //todo: implement refresh
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Status: ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  () {
                    switch (bleState) {
                      case BleConState.connected:
                        return "Connected";
                      case BleConState.connecting:
                        return "Connecting...";
                      case BleConState.searching:
                        return "Searching...";
                      case BleConState.disconnected:
                        return "Bluetooth OFF";
                    }
                  }(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            child: Column(
              children: [
                ArrowButton(
                  icon: Icons.arrow_upward,
                  onPressedCallback: () {
                    print("up");
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ArrowButton(
                      icon: Icons.arrow_back,
                      onPressedCallback: () {
                        print("left");
                      },
                    ),
                    ArrowButton(
                      icon: Icons.arrow_forward,
                      onPressedCallback: () {
                        print("right");
                      },
                    ),
                  ],
                ),
                ArrowButton(
                  icon: Icons.arrow_downward,
                  onPressedCallback: () {
                    print("down");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressedCallback;
  bool _pressState = false;

  ArrowButton({required this.icon, required this.onPressedCallback});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails val) async {
        _pressState = true;
        do {
          onPressedCallback();
          await Future.delayed(Duration(seconds: 1));
        } while (_pressState == true);
      },
      onTapCancel: () {
        _pressState = false;
      },
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Icon(icon),
        ),
      ),
    );
  }
}

enum BleConState { connected, connecting, searching, disconnected }
