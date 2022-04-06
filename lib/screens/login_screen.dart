import 'package:flutter/material.dart';
import 'package:iot_project/screens/screen1.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  List<Widget> getLoginForm(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
        child: TextFormField(
          // validator: (val) {
          //   if (regex.hasMatch(val!.trim()) || val.trim() == '') {
          //     return null;
          //   } else {
          //     return 'Enter only numbers!';
          //   }
          // },
          // onSaved: (val) {
          //   if (val!.trim() != '') {
          //     machineData[i]['metrics'][widget.fields[j]['fieldName']] =
          //         val.trim();
          //   }
          // },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(
              color: Color(0xFF8B97A2),
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF1A1F24),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF1A1F24),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            // filled: true,
            // fillColor: Colors.orangeAccent,
            contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
        child: TextFormField(
          // validator: (val) {
          //   if (widget.fields[j]['fieldType'] == "numeric") {
          //     if (regex.hasMatch(val!.trim()) || val.trim() == '') {
          //       return null;
          //     } else {
          //       return 'Enter only numbers!';
          //     }
          //   } else {
          //     return null;
          //   }
          // },
          // onSaved: (val) {
          //   if (val!.trim() != '') {
          //     machineData[i]['metrics'][widget.fields[j]['fieldName']] =
          //         val.trim();
          //   }
          // },
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(
              color: Color(0xFF8B97A2),
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF1A1F24),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF1A1F24),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            // filled: true,
            // fillColor: Colors.orangeAccent,
            contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      SizedBox(
        height: 45,
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 55,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Screen1(
                  screenBackgroundColor: Colors.grey[300]!,
                  titleCards: [
                    TitleCard(
                      cardTitle: "Placeholder 1",
                      cardColor: Colors.white,
                      subCardsColor: Colors.green,
                      subCards: [
                        SubCard(
                            icon: Icons.ac_unit_outlined, name: "Subcard 1"),
                        SubCard(
                            icon: Icons.airline_seat_legroom_extra_rounded,
                            name: "Subcard 2"),
                        SubCard(icon: Icons.water, name: "Subcard 3"),
                        SubCard(icon: Icons.house, name: "Subcard 4"),
                        SubCard(icon: Icons.card_travel, name: "Subcard 5"),
                        SubCard(
                            icon: Icons.account_tree_outlined,
                            name: "Subcard 6"),
                      ],
                    ),
                    TitleCard(
                      cardTitle: "Placeholder 2",
                      cardColor: Colors.white,
                      subCardsColor: Colors.green,
                      subCards: [
                        SubCard(
                            icon: Icons.ac_unit_outlined, name: "Subcard 1"),
                        SubCard(
                            icon: Icons.airline_seat_legroom_extra_rounded,
                            name: "Subcard 2"),
                        SubCard(icon: Icons.water, name: "Subcard 3"),
                        SubCard(icon: Icons.house, name: "Subcard 4"),
                        SubCard(icon: Icons.card_travel, name: "Subcard 5"),
                        SubCard(
                            icon: Icons.account_tree_outlined,
                            name: "Subcard 6"),
                      ],
                    ),
                    TitleCard(
                      cardTitle: "Placeholder 2",
                      cardColor: Colors.white,
                      subCardsColor: Colors.green,
                      subCards: [
                        SubCard(
                            icon: Icons.ac_unit_outlined, name: "Subcard 1"),
                        SubCard(
                            icon: Icons.airline_seat_legroom_extra_rounded,
                            name: "Subcard 2"),
                        SubCard(icon: Icons.water, name: "Subcard 3"),
                        SubCard(icon: Icons.house, name: "Subcard 4"),
                        SubCard(icon: Icons.card_travel, name: "Subcard 5"),
                        SubCard(
                            icon: Icons.account_tree_outlined,
                            name: "Subcard 6"),
                      ],
                    ),
                    TitleCard(
                      cardTitle: "Placeholder 2",
                      cardColor: Colors.white,
                      subCardsColor: Colors.green,
                      subCards: [
                        SubCard(
                            icon: Icons.ac_unit_outlined, name: "Subcard 1"),
                        SubCard(
                            icon: Icons.airline_seat_legroom_extra_rounded,
                            name: "Subcard 2"),
                        SubCard(icon: Icons.water, name: "Subcard 3"),
                        SubCard(icon: Icons.house, name: "Subcard 4"),
                        SubCard(icon: Icons.card_travel, name: "Subcard 5"),
                        SubCard(
                            icon: Icons.account_tree_outlined,
                            name: "Subcard 6"),
                      ],
                    ),
                    TitleCard(
                      cardTitle: "Placeholder 2",
                      cardColor: Colors.white,
                      subCardsColor: Colors.green,
                      subCards: [
                        SubCard(
                            icon: Icons.ac_unit_outlined, name: "Subcard 1"),
                        SubCard(
                            icon: Icons.airline_seat_legroom_extra_rounded,
                            name: "Subcard 2"),
                        SubCard(icon: Icons.water, name: "Subcard 3"),
                        SubCard(icon: Icons.house, name: "Subcard 4"),
                        SubCard(icon: Icons.card_travel, name: "Subcard 5"),
                        SubCard(
                            icon: Icons.account_tree_outlined,
                            name: "Subcard 6"),
                      ],
                    ),
                    TitleCard(
                      cardTitle: "Placeholder 2",
                      cardColor: Colors.white,
                      subCardsColor: Colors.green,
                      subCards: [
                        SubCard(
                            icon: Icons.ac_unit_outlined, name: "Subcard 1"),
                        SubCard(
                            icon: Icons.airline_seat_legroom_extra_rounded,
                            name: "Subcard 2"),
                        SubCard(icon: Icons.water, name: "Subcard 3"),
                        SubCard(icon: Icons.house, name: "Subcard 4"),
                        SubCard(icon: Icons.card_travel, name: "Subcard 5"),
                        SubCard(
                            icon: Icons.account_tree_outlined,
                            name: "Subcard 6"),
                      ],
                    ),
                    TitleCard(
                      cardTitle: "Placeholder 2",
                      cardColor: Colors.white,
                      subCardsColor: Colors.green,
                      subCards: [
                        SubCard(
                            icon: Icons.ac_unit_outlined, name: "Subcard 1"),
                        SubCard(
                            icon: Icons.airline_seat_legroom_extra_rounded,
                            name: "Subcard 2"),
                        SubCard(icon: Icons.water, name: "Subcard 3"),
                        SubCard(icon: Icons.house, name: "Subcard 4"),
                        SubCard(icon: Icons.card_travel, name: "Subcard 5"),
                        SubCard(
                            icon: Icons.account_tree_outlined,
                            name: "Subcard 6"),
                      ],
                    ),
                    TitleCard(
                      cardTitle: "Placeholder 2",
                      cardColor: Colors.white,
                      subCardsColor: Colors.green,
                      subCards: [
                        SubCard(
                            icon: Icons.ac_unit_outlined, name: "Subcard 1"),
                        SubCard(
                            icon: Icons.airline_seat_legroom_extra_rounded,
                            name: "Subcard 2"),
                        SubCard(icon: Icons.water, name: "Subcard 3"),
                        SubCard(icon: Icons.house, name: "Subcard 4"),
                        SubCard(icon: Icons.card_travel, name: "Subcard 5"),
                        SubCard(
                            icon: Icons.account_tree_outlined,
                            name: "Subcard 6"),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          child: Text(
            "Login",
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Text(
              "Warehouse",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 45,
            ),
            Expanded(
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: ListView(
                  children: getLoginForm(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
