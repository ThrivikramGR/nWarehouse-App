import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  final List<TitleCard> titleCards;
  Screen1({required this.titleCards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: titleCards.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                  color: titleCards[index].cardColor,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleCards[index].cardTitle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 70,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: titleCards[index].subCards.length,
                        itemBuilder: (context, subCardIndex) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8,
                                ),
                              ),
                              color: titleCards[index].subCardsColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  titleCards[index].subCards[subCardIndex].icon,
                                ),
                                Text(
                                  titleCards[index].subCards[subCardIndex].name,
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 15,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 15,
              );
            },
          ),
        ),
      ),
    );
  }
}

class TitleCard {
  final String cardTitle;
  final List<SubCard> subCards;
  final Color cardColor;
  final Color subCardsColor;

  TitleCard(
      {required this.cardTitle,
      required this.subCards,
      required this.cardColor,
      required this.subCardsColor});
}

class SubCard {
  final String name;
  final IconData icon;

  SubCard({required this.icon, required this.name});
}
