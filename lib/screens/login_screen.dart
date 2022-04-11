import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum DialogType { invalidUsername, invalidCredentials }

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? _userName;
  late String _password;

  void showNoUserDialog(DialogType dialogType) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Not Authorized!"),
          content: Text(
            dialogType == DialogType.invalidUsername
                ? "Invalid Username / Username not registered yet"
                : "Incorrect Username or Password",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Not Authorized!"),
          content: Text(
            dialogType == DialogType.invalidUsername
                ? "Invalid Username / Username not registered yet"
                : "Incorrect Username or Password",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        ),
      );
    }
  }

  bool _validateInputs() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
      return false;
    }
  }

  List<Widget> getLoginForm(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
        child: TextFormField(
          validator: (val) {
            if (val!.trim() != '') {
              return null;
            } else {
              return 'Enter Username';
            }
          },
          onSaved: (val) {
            _userName = val!.trim();
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Username",
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
            filled: true,
            fillColor: Colors.white,
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
          validator: (val) {
            if (val!.trim() != '' && val.trim().length >= 8) {
              return null;
            } else {
              return 'Enter a valid Password';
            }
          },
          onSaved: (val) {
            _password = val!.trim();
          },
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
            filled: true,
            fillColor: Colors.white,
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
          onPressed: () async {
            FocusScope.of(context).requestFocus(new FocusNode());

            if (_validateInputs()) {
              //todo:loadingSpinner
              //todo: fix error not running in oneplus
              await FirebaseFirestore.instance
                  .collection("users")
                  .where("userName", isEqualTo: _userName)
                  .limit(1)
                  .get()
                  .then((value) async {
                if (value.docs.isEmpty) {
                  showNoUserDialog(DialogType.invalidUsername);
                } else {
                  String _email = value.docs[0]['email'];
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          username: _userName,
                        ),
                      ),
                    );
                  } catch (e) {
                    showNoUserDialog(DialogType.invalidCredentials);
                  }
                }
              });
            }
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
              "NWarehouse",
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
