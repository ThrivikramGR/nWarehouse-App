import 'package:flutter/material.dart';

import '../slot_screen.dart';

class WarehousePage extends StatefulWidget {
  final String username;
  WarehousePage({required this.username});

  @override
  State<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends State<WarehousePage> {
  String getGreeting() {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning,";
    } else if (hour < 14) {
      return "Good Noon,";
    } else if (hour < 17) {
      return "Good Afternoon,";
    } else if (hour < 20) {
      return "Good Evening,";
    } else {
      return "Good Night,";
    }
  }

  String dropdownValue = 'default';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreeting(),
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.username[0].toUpperCase() + widget.username.substring(1),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 5),
        // Center(
        //   child: Text(
        //     "Enter Warehouse ID",
        //     style: TextStyle(
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 40,
        // ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 25),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       labelText: "Warehouse ID",
        //       labelStyle: TextStyle(
        //         color: Color(0xFF8B97A2),
        //         fontWeight: FontWeight.normal,
        //         fontSize: 14,
        //       ),
        //       enabledBorder: OutlineInputBorder(
        //         borderSide: BorderSide(
        //           color: Color(0xFF1A1F24),
        //           width: 1,
        //         ),
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderSide: BorderSide(
        //           color: Color(0xFF1A1F24),
        //           width: 2,
        //         ),
        //         borderRadius: BorderRadius.circular(
        //           8,
        //         ),
        //       ),
        //       filled: true,
        //       fillColor: Colors.white,
        //       contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
        //     ),
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16,
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xFF1A1F24),
                width: 2,
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: DropdownButton<String>(
                underline: SizedBox(),
                value: dropdownValue,
                items: [
                  DropdownMenuItem<String>(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Choose Warehouse",
                        style: TextStyle(
                          // color: Color(0xFF8B97A2),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    value: 'default',
                  ),
                  DropdownMenuItem<String>(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "34242cge",
                        style: TextStyle(
                          // color: Color(0xFF8B97A2),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    value: '342',
                  ),
                  DropdownMenuItem<String>(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "4353t435",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    value: '435',
                  ),
                  DropdownMenuItem<String>(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "3456345",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    value: '345',
                  ),
                ],
                elevation: 5,
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value!;
                    print(value);
                  });
                },
                icon: Icon(Icons.keyboard_arrow_down_sharp),
                isExpanded: true,
                dropdownColor: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 45,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SlotScreen()),
              );
            },
            child: Text(
              "View Warehouse",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
            ),
            // style: ButtonStyle(
            //   backgroundColor: MaterialStateProperty.all(
            //     Colors.blue,
            //   ),
            // ),
          ),
        ),

        Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Detailed Report",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            // style: ButtonStyle(
            //   backgroundColor: MaterialStateProperty.all(
            //     Colors.blue,
            //   ),
          ),
        ),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     ElevatedButton(
        //       onPressed: () {},
        //       child: Text("View Warehouse"),
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all(
        //           Colors.blue,
        //         ),
        //       ),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {},
        //       child: Text("Detailed Report"),
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all(
        //           Colors.blue,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
