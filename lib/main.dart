import 'package:flutter/material.dart';
import 'package:rivlus_webview_app/inapp_webview.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewWebView();
  }
}
