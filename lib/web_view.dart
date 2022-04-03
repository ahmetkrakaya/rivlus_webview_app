import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rivlus_webview_app/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

var _url = '';

class WebViewer extends StatefulWidget {
  final String _url = '';
  @override
  WebViewerState createState() => WebViewerState();
}

class WebViewerState extends State<WebViewer> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          backgroundColor: Color(0xFF2d2a6d),
          title: const Text(
            'Rivlus WebView App',
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: WebView(
          initialUrl: _url.toString(),
        ),
      ),
    );
  }
}
