import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/workflows/gallery_page.dart';
import 'package:iot_project/workflows/home/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  late ConfettiController _controllerCenter;
  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    confetti();
  }

  void confetti() async {
    _controllerCenter.play();
    await Future.delayed(Duration(seconds: 2));
    _controllerCenter.stop();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                CustomHomeTopBanner(),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Container(
                    color: Colors.black38,
                    child: Column(
                      children: [
                        Text(
                          "Mission",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Digital Defence for Grains from Warehouses to Households\nகிடங்குகள் முதல் வீடுகள் வரை தானியங்களுக்கான எண்மப் பாதுகாப்பு",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Vision",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Technology Interface for Sustainable Growth\nநிலையான வளர்ச்சிக்குரிய தொழில்நுட்ப இடைமுகம்",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade800,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 110,
                      child: Center(
                        child: Text(
                          "Mobile App",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse("https://n-warehouse.com/"));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.green.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 80,
                        child: Center(
                          child: Text(
                            "n-warehouse.com",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GalleryPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.green.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 80,
                        child: Center(
                          child: Text(
                            "IoT Devices",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
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
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              numberOfParticles: 10,
              emissionFrequency: 0.3,
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class CustomHomeTopBanner extends StatelessWidget {
//   const CustomHomeTopBanner({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       borderRadius: BorderRadius.vertical(
//         bottom: Radius.circular(30),
//       ),
//       elevation: 5,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFFFFF3CE),
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(30),
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 45,
//             ),
//             Text(
//               "NWarehouse Pvt. Ltd.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 55,
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Text(
//               "Successfully Launched!",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.green.shade800,
//                 fontSize: 35,
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
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
