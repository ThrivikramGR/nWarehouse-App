import 'dart:io' show Platform;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_project/screens/home/home_screen.dart';
import 'package:iot_project/services/color_config.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum DialogType { invalidUsername, invalidCredentials }

class _LoginPageState extends State<LoginPage> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? _userName;
  String? _password;

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
        height: 20,
      ),
    ];
  }

  void login() async {
    //to dismiss keyboard when button pressed
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_validateInputs()) {
      Response response = await Dio().post(
          "https://nodeapifordb.vercel.app/api/users/signin",
          data: {"Username": "MAHA", "password": "Ma12345"});
      print(response.statusCode);
      print(response.statusMessage);
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
                      "assets/images/nw_bg.png",
                    ),
                    SizedBox(
                      height: 80,
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
                          top: 15,
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
                              height: 15,
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
                        'Sign in',
                        style: TextStyle(
                          fontFamily: "NunitoSans",
                          color: Colors.white,
                        ),
                      ),
                      successColor: Colors.green,
                      controller: _btnController,
                      onPressed: login,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Sign up",
                      ),
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
}
