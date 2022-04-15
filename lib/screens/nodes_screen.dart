import 'package:flutter/material.dart';
import 'package:iot_project/screens/screen1.dart';

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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              elevation: 1,
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Screen1(
                        titleCards: [
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
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
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              elevation: 1,
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Screen1(
                        titleCards: [
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  child: Text(
                    "Mobile Node",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              elevation: 1,
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Screen1(
                        titleCards: [
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                          TitleCard(
                            cardTitle: "Card1",
                            subCards: [
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                              SubCard(icon: Icons.sensors, name: "Subcard 1"),
                            ],
                            cardColor: Colors.white,
                            subCardsColor: Colors.grey[300]!,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  child: Text(
                    "Probe Node",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
