import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final List<TextFieldObject> textFields = [
    TextFieldObject(
      labelText: "Name",
      requiredField: true,
      dbName: "name",
    ),
    TextFieldObject(
      labelText: "Location",
      dbName: "location",
    ),
    TextFieldObject(
      labelText: "Joined On",
      dbName: "joinedsince",
    ),
    TextFieldObject(
      labelText: "Tier",
      dbName: "tier",
    ),
    TextFieldObject(
      labelText: "Warehouse ID",
      keyboardType: TextInputType.number,
      dbName: "warehouseID",
    ),
    TextFieldObject(
      labelText: "Phone Number",
      keyboardType: TextInputType.number,
      dbName: "phonenumber",
    ),
    TextFieldObject(
      labelText: "Email",
      dbName: "mailid",
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

  void submitForm() async {
    final queryParameters = textFieldValues;

    var dio = Dio();
    await dio.post(
        'http://node-js-new.herokuapp.com/api/userprofileregistration',
        data: queryParameters);
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
            labelText: textFields[index].labelText,
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
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          keyboardType: textFields[index].keyboardType,
          obscureText: textFields[index].obscureText,
          validator: (value) {
            if (textFields[index].requiredField == true) {
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
            } else {
              if (textFields[index].ensureNumbersOnly == true) {
                if (regExp.hasMatch(value!.trim()) || value.trim() == '') {
                  return null;
                } else {
                  return "Enter only numbers!";
                }
              } else {
                return null;
              }
            }
          },
          onSaved: (value) {
            textFieldValues[textFields[index].dbName] = value!.trim();
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
              submitForm();
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF92A65F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 55,
            ),
            child: Text(
              "Register",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
    return formChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          "User Registration",
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF323232),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 12,
          ),
          Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
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
    );
  }
}

class TextFieldObject {
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool ensureNumbersOnly;
  final bool requiredField;
  final String dbName;
  TextFieldObject({
    required this.dbName,
    required this.labelText,
    this.keyboardType = TextInputType.name,
    this.obscureText = false,
    this.ensureNumbersOnly = false,
    this.requiredField = false,
  });
}
