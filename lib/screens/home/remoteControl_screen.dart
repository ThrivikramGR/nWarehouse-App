import 'package:flutter/material.dart';

class RemoteControlScreen extends StatefulWidget {
  const RemoteControlScreen({Key? key}) : super(key: key);

  @override
  State<RemoteControlScreen> createState() => _RemoteControlScreenState();
}

class _RemoteControlScreenState extends State<RemoteControlScreen> {
  Map<Direction, bool> pressStateMap = {
    Direction.UP: false,
    Direction.DOWN: false,
    Direction.LEFT: false,
    Direction.RIGHT: false,
  };

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
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTapDown: (TapDownDetails val) async {
                pressStateMap[Direction.LEFT] = true;
                do {
                  print("left Pressed");
                  await Future.delayed(Duration(seconds: 1));
                } while (pressStateMap[Direction.LEFT] == true);
              },
              onTapCancel: () {
                pressStateMap[Direction.LEFT] = false;
              },
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTapDown: (TapDownDetails val) async {
                    pressStateMap[Direction.UP] = true;

                    do {
                      print("up Pressed");
                      await Future.delayed(Duration(seconds: 1));
                    } while (pressStateMap[Direction.UP] == true);
                  },
                  onTapCancel: () {
                    pressStateMap[Direction.UP] = false;
                  },
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Icon(
                        Icons.arrow_upward,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails val) async {
                    pressStateMap[Direction.DOWN] = true;

                    do {
                      print("down Pressed");
                      await Future.delayed(Duration(seconds: 1));
                    } while (pressStateMap[Direction.DOWN] == true);
                  },
                  onTapCancel: () {
                    pressStateMap[Direction.DOWN] = false;
                  },
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Icon(
                        Icons.arrow_downward,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTapDown: (TapDownDetails val) async {
                pressStateMap[Direction.RIGHT] = true;

                do {
                  print("right Pressed");
                  await Future.delayed(Duration(seconds: 1));
                } while (pressStateMap[Direction.RIGHT] == true);
              },
              onTapCancel: () {
                pressStateMap[Direction.RIGHT] = false;
              },
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Direction { UP, DOWN, LEFT, RIGHT }
