import 'package:flutter/material.dart';
import 'package:iot_project/services/color_config.dart';

class UserProfilePage extends StatelessWidget {
  final String username;
  UserProfilePage({required this.username});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                color: ColorConfig.primaryBlue,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                username[0].toUpperCase() + username.substring(1),
                style: TextStyle(
                  fontSize: 35,
                  color: ColorConfig.primaryBlue,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 46,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "13",
                        style: TextStyle(
                          color: ColorConfig.primaryBlue,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Warehouses",
                        style: TextStyle(
                          color: ColorConfig.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                    width: 1,
                    color: ColorConfig.primaryBlue,
                  ),
                  Column(
                    children: [
                      Text(
                        "4000",
                        style: TextStyle(
                          color: ColorConfig.primaryBlue,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Slots",
                        style: TextStyle(
                          color: ColorConfig.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                    width: 1,
                    color: ColorConfig.primaryBlue,
                  ),
                  Column(
                    children: [
                      Text(
                        "24000",
                        style: TextStyle(
                          color: ColorConfig.primaryBlue,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Nodes",
                        style: TextStyle(
                          color: ColorConfig.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          decoration: BoxDecoration(
            color: ColorConfig.backgroundLightBlue,
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Info",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: ColorConfig.primaryBlue,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text(
                  "vikramthiru02@gmail.com",
                  style: TextStyle(
                    color: ColorConfig.primaryBlue,
                  ),
                ),
                subtitle: Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: ColorConfig.primaryBlue,
                  ),
                ),
                leading: Icon(
                  Icons.email,
                  color: ColorConfig.primaryBlue,
                ),
              ),
              ListTile(
                title: Text(
                  "+91 9994818238",
                  style: TextStyle(
                    color: ColorConfig.primaryBlue,
                  ),
                ),
                subtitle: Text(
                  "Mobile",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: ColorConfig.primaryBlue,
                  ),
                ),
                leading: Icon(
                  Icons.phone,
                  color: ColorConfig.primaryBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
