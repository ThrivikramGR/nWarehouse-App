import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IoT Devices Hardware"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 20,
            children: List.generate(
              32,
              (index) => GestureDetector(
                onTap: () {
                  showDialog(
                    barrierColor: Colors.black,
                    context: context,
                    builder: (context) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/gallery/img (${index + 1}).jpg",
                        height: 120,
                        width: 120,
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  "assets/images/gallery/img (${index + 1}).jpg",
                  height: 240,
                  width: 240,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
