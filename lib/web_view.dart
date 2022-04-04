import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rivlus_webview_app/common_widgets/alert_dialog.dart';
import 'package:rivlus_webview_app/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

final webViewKey = GlobalKey<WebViewContainerState>();

class WebViewer extends StatefulWidget {
  final String url;

  const WebViewer({Key? key, required this.url}) : super(key: key);

  @override
  WebViewerState createState() => WebViewerState();
}

class WebViewerState extends State<WebViewer> {
  WebViewController? _webViewController;

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
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () async {
                final result = await const CommonAlertDialog(
                  title: 'Çıkış Yap',
                  content:
                      'Uygulamadan çıkış yapmak istediğinize emin misiniz?',
                  mainButtonText: 'Evet',
                  cancelButtonText: 'Vazgeç',
                ).show(context);

                if (result == true) {
                  exit(0);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                webViewKey.currentState?.reloadWebView();
              }
            ),

          ],
        ),
        body: WebViewContainer(key: webViewKey,),
      ),
    );
  }
}


class WebViewContainer extends StatefulWidget {
  WebViewContainer({Key? key}) : super(key: key);

  @override
  WebViewContainerState createState() => WebViewContainerState();
}

class WebViewContainerState extends State<WebViewContainer> {
  WebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return WebView(
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      initialUrl: "https://www.kullananlar.com",
    );
  }

  void reloadWebView() {
    _webViewController?.reload();
  }
}
