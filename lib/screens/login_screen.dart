import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_project/screens/home/home_screen.dart';
import 'package:iot_project/services/color_config.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum DialogType { invalidUsername, invalidCredentials }

class _LoginScreenState extends State<LoginScreen> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/nLogo.png",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE5EAD9),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          top: 30,
                          left: 25,
                          right: 25,
                          bottom: 15,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                color: Color(0xFF323232),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Form(
                              key: _formKey,
                              autovalidateMode: _autoValidateMode,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: getLoginForm(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RoundedLoadingButton(
                      color: Color(0xFF92A65F),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: "NunitoSans",
                          color: Colors.white,
                        ),
                      ),
                      successColor: Colors.green,
                      controller: _btnController,
                      onPressed: login,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

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

  List<Widget> getLoginForm() {
    return [
      TextFormField(
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
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: "Username",
          labelStyle: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF8B97A2),
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF92A65F),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF92A65F),
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
          fontFamily: "NunitoSans",
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
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
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: "Password",
          labelStyle: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF8B97A2),
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF92A65F),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF92A65F),
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
          fontFamily: "NunitoSans",
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(
        height: 15,
      ),
      TextButton(
        onPressed: () {},
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: ColorConfig.primaryBlue,
          ),
        ),
      ),
    ];
  }

  void login() async {
    //to dismiss keyboard when button pressed
    FocusScope.of(context).requestFocus(new FocusNode());

    if (_validateInputs()) {
      await FirebaseFirestore.instance
          .collection("users")
          .where("userName", isEqualTo: _userName)
          .limit(1)
          .get()
          .then(
        (value) async {
          if (value.docs.isEmpty) {
            buttonErrorReset();
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
              buttonErrorReset();
              showNoUserDialog(DialogType.invalidCredentials);
            }
          }
        },
      );
    } else {
      buttonErrorReset();
    }
  }

  void buttonErrorReset() async {
    _btnController.error();
    await Future.delayed(
      Duration(seconds: 2),
    );
    _btnController.reset();
  }
}
