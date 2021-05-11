import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/views/home.dart';

class ConfirmScreen extends StatefulWidget {
  final String userEmail;
  ConfirmScreen({Key key, @required this.userEmail}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  String accessCode;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Brightness brightness = MediaQuery.platformBrightnessOf(context);

    return Scaffold(
      body: Container(
        color: brightness == Brightness.light
            ? CupertinoColors.extraLightBackgroundGray
            : Colors.black87,
        height: screenHeight * 1,
        width: screenWidth * 1,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Center(
                child: Text(
                  "Check Your Email!",
                  style: TextStyle(
                      color: brightness == Brightness.light
                          ? Colors.purple
                          : Colors.purpleAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: screenHeight * 0.08),
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
                        CupertinoIcons.lock_circle,
                        color: brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    Container(
                        width: screenWidth * 0.55,
                        child: CupertinoTextField(
                          placeholder: "Access Code",
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide.none)),
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
                            accessCode = value;
                          },
                        )),
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
                    try {
                      final res = Amplify.Auth.confirmSignUp(
                              username: widget.userEmail,
                              confirmationCode: accessCode)
                          .then((value) => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()))
                              });
                    } catch (e) {
                      print(e);
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
          ),
        )),
      ),
    );
  }
}
