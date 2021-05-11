import 'dart:io';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/views/authentication/auth_landing.dart';
import 'package:mobile_app/views/profiles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void uploadProfileImage() async {
    // use a file selection mechanism of your choice
    FilePickerResult res = await FilePicker.platform.pickFiles();
    if (res != null) {
      File file = File(res.files.single.path);
      final key = new DateTime.now().toString();
      Map<String, String> metadata = <String, String>{};
      metadata['name'] = 'filename';
      metadata['desc'] = 'A test file';
      S3UploadFileOptions options = S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest, metadata: metadata);
      try {
        UploadFileResult result = await Amplify.Storage.uploadFile(
            key: key, local: file, options: options);
      } on StorageException catch (e) {
        print(e.message);
      }
    } else {
      // User canceled the pickers
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Brightness brightness = MediaQuery.platformBrightnessOf(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            "Welcome",
            style: TextStyle(
                color: brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22),
          ),
          elevation: 0,
          backgroundColor: brightness == Brightness.light
              ? CupertinoColors.extraLightBackgroundGray
              : Colors.black87,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.logout),
                color: Colors.red,
                iconSize: 28,
                onPressed: () {
                  Amplify.Auth.signOut().then((value) => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthLandingScreen()))
                      });
                },
              ),
            )
          ],
        ),
        body: Container(
          color: brightness == Brightness.light
              ? CupertinoColors.extraLightBackgroundGray
              : Colors.black87,
          width: screenWidth * 1,
          height: screenHeight * 1,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.2),
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
                          uploadProfileImage();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Center(
                        child: Text("Set Profile Picture",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilesScreen()));
                      },
                      child: Center(
                        child: Text("Profiles",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
