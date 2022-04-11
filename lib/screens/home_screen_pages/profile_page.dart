import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text(
          "Logout",
        ),
        onPressed: () async {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, "/");
        },
      ),
    );
  }
}
