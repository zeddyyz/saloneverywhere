import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/views/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form Validation
  String email = '', password = '', errorMessage = '', authError = '';

  formValues() {
    setState(() {
      if (email == null) {
        errorMessage = 'Email is required.';
        displayDialog();
      } else if (password == null) {
        errorMessage = 'Password is required.';
        displayDialog();
      }
    });
  }

  // Alert Dialog
  void displayDialog() {
    Brightness brightness = MediaQuery.platformBrightnessOf(context);
    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              elevation: 0,
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              content: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: brightness == Brightness.light
                        ? Colors.white70
                        : Colors.black87),
                height: 152,
                width: 300,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.only(top: 25),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      '$errorMessage',
                      style: TextStyle(
                          color: brightness == Brightness.light
                              ? Colors.black
                              : Colors.white),
                    )),
                    SizedBox(height: 20),
                    Divider(
                        height: 1,
                        color: brightness == Brightness.light
                            ? Color(0xFF3C3C43).withOpacity(0.35)
                            : Colors.black87),
                    CupertinoButton(
                        child: Text("Close",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600)),
                        onPressed: () => {Navigator.of(context).pop()})
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    if (Device.get().isPhone || Device.get().isTablet) {
      return Scaffold(body: _mobileView());
    } else {
      return Device.get().isIos
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator();
    }
  }

  Widget _mobileView() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Brightness brightness = MediaQuery.platformBrightnessOf(context);
    final snackBar = SnackBar(content: Text('$authError'));

    return Container(
        color: brightness == Brightness.light
            ? CupertinoColors.extraLightBackgroundGray
            : Colors.black87,
        height: screenHeight * 1,
        width: screenWidth * 1,
        child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: screenHeight * 0.06),
                Container(
                    child: Text("Hi there!",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: brightness == Brightness.light
                                ? Colors.black.withOpacity(0.85)
                                : Colors.white.withOpacity(0.85)))),
                SizedBox(height: screenHeight * 0.01),
                Container(
                    child: Text("Sign In Please!",
                        style: TextStyle(
                            fontSize: 24,
                            color: brightness == Brightness.light
                                ? Colors.purpleAccent
                                : CupertinoColors.systemPurple,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: screenHeight * 0.15),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                      color: brightness == Brightness.light
                          ? Colors.white
                          : Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(
                          CupertinoIcons.person,
                          color: brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      Container(
                          width: screenWidth * 0.70,
                          child: CupertinoTextField(
                            placeholder: "Email",
                            clearButtonMode: OverlayVisibilityMode.editing,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide.none)),
                            style: TextStyle(
                                color: brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                            placeholderStyle: TextStyle(
                                color: brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                            keyboardAppearance: brightness == Brightness.light
                                ? Brightness.light
                                : Brightness.dark,
                            padding: const EdgeInsets.only(
                                left: 20, top: 15, right: 20, bottom: 15),
                            onChanged: (value) {
                              email = value;
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.013),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                      color: brightness == Brightness.light
                          ? Colors.white
                          : Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(
                          CupertinoIcons.lock,
                          color: brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      Container(
                          width: screenWidth * 0.70,
                          child: CupertinoTextField(
                            placeholder: "Password",
                            clearButtonMode: OverlayVisibilityMode.editing,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide.none)),
                            style: TextStyle(
                                color: brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                            placeholderStyle: TextStyle(
                                color: brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                            keyboardAppearance: brightness == Brightness.light
                                ? Brightness.light
                                : Brightness.dark,
                            padding: const EdgeInsets.only(
                                left: 20, top: 15, right: 20, bottom: 15),
                            onChanged: (value) {
                              password = value;
                            },
                          ))
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),
                Container(
                  decoration: BoxDecoration(
                      color: brightness == Brightness.light
                          ? Colors.purpleAccent
                          : Colors.deepPurple,
                      borderRadius: BorderRadius.circular(40)),
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.9,
                  child: GestureDetector(
                    onTap: () {
                      if (email == null || password == null) {
                        formValues();
                      } else {
                        try {
                          Amplify.Auth.signIn(
                                  username: email, password: password)
                              .then((value) => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()))
                                  });
                        } catch (e) {
                          print(e);
                          authError = e;
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text("Continue",
                              style: TextStyle(
                                  color: brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 26,
                          color: brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ))));
  }
}
