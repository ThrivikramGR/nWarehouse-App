import 'package:flutter/material.dart';

class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final List<TextFieldObject> textFields = [
    TextFieldObject(
      labelText: "Username",
    ),
    TextFieldObject(
      labelText: "Phone",
      keyboardType: TextInputType.number,
      ensureNumbersOnly: true,
    ),
    TextFieldObject(
      labelText: "Warehouse Location",
    ),
    TextFieldObject(
      labelText: "Number of Lots",
      keyboardType: TextInputType.number,
      ensureNumbersOnly: true,
    ),
    TextFieldObject(
      labelText: "Number of Nodes",
      keyboardType: TextInputType.number,
      ensureNumbersOnly: true,
    ),
    TextFieldObject(
      labelText: "Warehouse Dimension",
    ),
    TextFieldObject(
      labelText: "Gateway ID",
    ),
    TextFieldObject(
      labelText: "Access Point ID",
    ),
    TextFieldObject(
      labelText: "Number of Repeaters",
      keyboardType: TextInputType.number,
      ensureNumbersOnly: true,
    ),
    TextFieldObject(
      labelText: "Email",
      keyboardType: TextInputType.emailAddress,
    ),
    TextFieldObject(
      labelText: "Password",
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
    ),
  ];

  bool _validateInputs() {
    if (_formKey.currentState!.validate()) {
//    If all data are correct then save data to out variables

      _formKey.currentState!.save();
      return true;
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
      return false;
    }
  }

  Map<String, String> textFieldValues = {};

  List<Widget> getForm() {
    String numberPattern = r'^-?[0-9]+$';
    RegExp regExp = RegExp(numberPattern);
    List<Widget> formChildren = List.generate(textFields.length, (index) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: textFields[index].labelText,
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
          keyboardType: textFields[index].keyboardType,
          obscureText: textFields[index].obscureText,
          validator: (value) {
            if (value?.trim() != '') {
              if (textFields[index].ensureNumbersOnly == true) {
                if (regExp.hasMatch(value!.trim())) {
                  return null;
                } else {
                  return "Enter only numbers!";
                }
              } else {
                return null;
              }
            } else {
              return 'Required field!';
            }
          },
          onSaved: (value) {
            textFieldValues[textFields[index].labelText] = value!.trim();
          },
        ),
      );
    });
    formChildren.add(
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {
            if (_validateInputs()) {
              print(textFieldValues);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 55,
            ),
            child: Text(
              "Register",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
    return formChildren;
  }

  // List<Widget> getLoginForm(BuildContext context) {
  //   String regexIntPattern = r'^-?[0-9]+$';
  //
  //   return [
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           labelText: "Username",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           labelText: "Phone",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           labelText: "Warehouse Location",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           labelText: "Number of Lots",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           labelText: "Number of Nodes",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           labelText: "Warehouse Dimension",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           labelText: "Gateway ID",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           labelText: "Access point ID",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         obscureText: true,
  //         keyboardType: TextInputType.visiblePassword,
  //         decoration: InputDecoration(
  //           labelText: "Number of Repeaters",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         obscureText: true,
  //         keyboardType: TextInputType.visiblePassword,
  //         decoration: InputDecoration(
  //           labelText: "Email",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: TextFormField(
  //         obscureText: true,
  //         keyboardType: TextInputType.visiblePassword,
  //         decoration: InputDecoration(
  //           labelText: "Password",
  //           labelStyle: TextStyle(
  //             color: Color(0xFF8B97A2),
  //             fontWeight: FontWeight.normal,
  //             fontSize: 14,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Color(0xFF1A1F24),
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.circular(
  //               8,
  //             ),
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  //         ),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     SizedBox(
  //       height: 20,
  //     ),
  //     ElevatedButton(
  //       onPressed: () {},
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(
  //           vertical: 15,
  //           horizontal: 55,
  //         ),
  //         child: Text(
  //           "Register",
  //           style: TextStyle(
  //             fontSize: 18,
  //           ),
  //         ),
  //       ),
  //     ),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Registration",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 35,
                ),
                child: Column(
                  children: getForm(),
                ),
              ),
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

class TextFieldObject {
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool ensureNumbersOnly;
  TextFieldObject({
    required this.labelText,
    this.keyboardType = TextInputType.name,
    this.obscureText = false,
    this.ensureNumbersOnly = false,
  });
}
