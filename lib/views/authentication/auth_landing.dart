import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/views/authentication/login.dart';
import 'package:mobile_app/views/authentication/register.dart';

import '../../amplifyconfiguration.dart';

class AuthLandingScreen extends StatefulWidget {
  @override
  _AuthLandingScreenState createState() => _AuthLandingScreenState();
}

class _AuthLandingScreenState extends State<AuthLandingScreen> {
  // AMPLIFY SETUP
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    if (!mounted) return;

    // Add Pinpoint and Cognito Plugins
    Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print("Amplify was already configured. Was the app restarted?");
    }
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
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
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [Color(0xffB527E7), Color(0xff27A2E7)])),
        child: SafeArea(
            child: Column(
          children: [
            Container(
              height: screenHeight * 0.15,
              child: Center(
                child: Text("SalonEverywhere",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            SizedBox(height: screenHeight * 0.18),
            Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                children: [
                  Spacer(),
                  Center(
                    child: Text(
                      "The Platform for",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Hair & Beauty Pros",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
            Spacer(),
            Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Container(
                        child: Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20)),
                        width: screenWidth * 0.9,
                        height: 40),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Container(
                          child: Center(
                              child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          width: screenWidth * 0.9,
                          height: 40),
                    ),
                  )
                ]))
          ],
        )));
  }
}
