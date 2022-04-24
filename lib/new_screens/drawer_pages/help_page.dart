import 'package:flutter/material.dart';

import '../../custom_widgets/inkwell_container.dart';
import '../../services/color_config.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20),
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: CustomInkwellContainer(
            onPressed: () {},
            height: 85,
            backgroundColor: ColorConfig.backgroundLightBlue,
            splashColor: Colors.blue[200],
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
                        "Terms of Service",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConfig.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.format_align_left,
                    color: ColorConfig.primaryBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: CustomInkwellContainer(
            onPressed: () {},
            height: 85,
            backgroundColor: ColorConfig.backgroundLightBlue,
            splashColor: Colors.blue[200],
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
                        "Troubleshooting",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConfig.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.warning_amber_outlined,
                    color: ColorConfig.primaryBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: CustomInkwellContainer(
            onPressed: () {},
            height: 85,
            backgroundColor: ColorConfig.backgroundLightBlue,
            splashColor: Colors.blue[200],
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
                        "Contact the developer",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConfig.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.message,
                    color: ColorConfig.primaryBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
