import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/views/authentication/auth_landing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.platformBrightnessOf(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: MaterialApp(
          title: 'SalonEverywhere',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthLandingScreen()),
    );
  }
}
