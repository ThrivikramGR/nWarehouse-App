import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/workflows/login_signup/signUp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void validateInputs() {
    FocusScope.of(context).requestFocus(new FocusNode()); //dismiss keyboard
    RegExp regex = RegExp(r"^[a-zA-Z\d+_.-]+@[a-zA-Z\d.-]+$");
    if (!regex.hasMatch(_emailController.text.trim()) ||
        _emailController.text.trim().length < 5) {
      displaySnackBar("Invalid Email!");
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      displaySnackBar("Invalid Password!");
      return;
    }
    setState(() {
      isLoading = true;
    });
    signIn(_emailController.text.trim(), _passwordController.text.trim());
  }

  void signIn(String email, String password) async {
    try {
      Response response = await Dio()
          .post("https://api.n-warehouse.com/api/users/login", data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode != 200) {
        displaySnackBar("Failed to Login!");
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (response.data["success"] != 1) {
        _passwordController.clear();
        displaySnackBar("Invalid Email or Password!");
        setState(() {
          isLoading = false;
        });

        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", response.data["token"]);
      await prefs.setString("email", email);
      Navigator.pushReplacementNamed(context, "home");
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomLogoNameBanner(),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 14,
                  vertical: 60,
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
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
                      height: MediaQuery.of(context).size.height / 8,
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
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUpPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
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

class CustomLogoNameBanner extends StatelessWidget {
  const CustomLogoNameBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF3CE),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(35),
        ),
      ),
      padding: EdgeInsets.only(bottom: 50, top: 30),
      child: Column(
        children: [
          Image.asset(
            "assets/images/nw_logo.png",
            width: 200,
            height: 200,
          ),
          Text(
            "NWarehouse Pvt. Ltd.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
