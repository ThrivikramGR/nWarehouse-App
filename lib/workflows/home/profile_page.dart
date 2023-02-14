import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom_widgets/inkwell_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  String email = "";
  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email")!;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            LineIcons.userCircle,
            color: Color(0xFF323232),
            size: 80,
          ),
          Column(
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
                              "Admin",
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF323232),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Role",
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                color: Color(0xFF323232),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          LineIcons.userTie,
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
                              isLoading ? "     @gmail.com" : email,
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF323232),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Email",
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                color: Color(0xFF323232),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          LineIcons.envelope,
                          color: Color(0xFF323232),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
