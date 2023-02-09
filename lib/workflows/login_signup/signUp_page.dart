import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void displaySnackBar(String message,
      {Color color = Colors.red, int durationInSeconds = 3}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: durationInSeconds),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  void validateInputs() {
    FocusScope.of(context).requestFocus(new FocusNode()); //dismiss keyboard
    RegExp regex = RegExp(r"^[a-zA-Z\d+_.-]+@[a-zA-Z\d.-]+$");
    if (!regex.hasMatch(_emailController.text.trim()) ||
        _emailController.text.trim().length < 5) {
      displaySnackBar("Invalid Email!");
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      displaySnackBar("Password cannot be empty!");
      return;
    }
    if (_usernameController.text.trim().isEmpty) {
      displaySnackBar("Username cannot be empty!");
      return;
    }
    setState(() {
      isLoading = true;
    });
    signUp(_emailController.text.trim(), _passwordController.text.trim(),
        _usernameController.text.trim());
  }

  void signUp(String email, String password, String username) async {
    try {
      Response response =
          await Dio().post("https://api.n-warehouse.com/api/users", data: {
        "email": email,
        "password": password,
        "username": username,
      });
      if (response.statusCode != 200) {
        displaySnackBar("Failed to Signup!");
        return;
      }
      if (response.data["success"] != 1) {
        displaySnackBar("Invalid Email or Password!");
        return;
      }
      displaySnackBar("Sign up successful!",
          color: Colors.green, durationInSeconds: 3);
      Navigator.pop(context);
    } catch (e) {
      displaySnackBar("Check your connection!");
    }
    setState(() {
      isLoading = false;
    });
  }

  bool visiblePassword = false;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 14,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          textInputAction: TextInputAction.next,
                          controller: _usernameController,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            counterText: "",
                            prefixIcon: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black,
                            ),
                            labelText: "Username",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade600,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 23, bottom: 23, left: 50, right: 5),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          textInputAction: TextInputAction.next,
                          controller: _emailController,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            counterText: "",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade600,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 23, bottom: 23, left: 50, right: 5),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          textInputAction: TextInputAction.done,
                          controller: _passwordController,
                          textCapitalization: TextCapitalization.none,
                          obscureText: !visiblePassword,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            counterText: "",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visiblePassword = !visiblePassword;
                                });
                              },
                              icon: Icon(
                                visiblePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade600,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 23, bottom: 23, left: 50, right: 5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF4B804),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: isLoading ? null : validateInputs,
                            child: isLoading
                                ? SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
