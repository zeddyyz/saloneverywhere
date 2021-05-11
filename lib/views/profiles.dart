import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfilesScreen extends StatefulWidget {
  @override
  _ProfilesScreenState createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.platformBrightnessOf(context);
    return Scaffold(
      body: Container(
        color: brightness == Brightness.light
            ? CupertinoColors.extraLightBackgroundGray
            : Colors.black87,
        child: SafeArea(
          bottom: false,
          child: WebView(
            initialUrl: 'https://saloneverywhere.com/sample-profiles',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }
}
