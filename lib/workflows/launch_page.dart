import 'package:flutter/material.dart';
import 'package:iot_project/thankyou_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF3CE),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/farm.png",
            ),
          ),
        ),
        // color: Color(0xFFFFF3CE),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   padding: EdgeInsets.only(top: 45),
            //   color: Color(0xFFFFF3CE),
            //   child: Image.asset(
            //     "assets/images/nw_logo.png",
            //     height: 100,
            //   ),
            // ),
            CustomHomeTopBanner(),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Container(
                color: Colors.black38,
                child: Text(
                  "We request\nDr. Manish Diwan\nHead - Strategic Partnership, BIRAC\nto launch the product!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 75),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThankYouPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade700,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 150,
                  child: Center(
                    child: Text(
                      "Launch KAAPPAAN",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 3,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.white,
                  child: Image.asset(
                    "assets/images/ccamp.png",
                    width: 200,
                  ),
                ),
                Image.asset(
                  "assets/images/tbi.png",
                  width: 300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHomeTopBanner extends StatelessWidget {
  const CustomHomeTopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFF3CE),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/images/nw_logo.png",
              height: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "NWarehouse Pvt. Ltd.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                fontSize: 50,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "\"KAAPPAAN\"",
              style: TextStyle(
                color: Colors.green.shade800,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w800,
                letterSpacing: 3,
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Supported by",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/birac_logo.png",
                  width: 200,
                ),
                Image.asset(
                  "assets/images/sas2.png",
                  width: 300,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
