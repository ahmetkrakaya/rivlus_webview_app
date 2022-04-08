import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rivlus_webview_app/common_widgets/alert_dialog.dart';

class NewWebView extends StatefulWidget {
  const NewWebView({Key? key}) : super(key: key);

  @override
  State<NewWebView> createState() => _NewWebViewState();
}

class _NewWebViewState extends State<NewWebView> {
  final GlobalKey webViewKey = GlobalKey();
  late PullToRefreshController pullToRefreshController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  InAppWebViewController? _webViewController;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _webViewController?.reload();
        } else if (Platform.isIOS) {
          _webViewController?.loadUrl(
              urlRequest: URLRequest(url: await _webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final result = await const CommonAlertDialog(
            title: 'Çıkış Yap',
            content: 'Uygulamadan çıkış yapmak istediğinize emin misiniz?',
            mainButtonText: 'Evet',
            cancelButtonText: 'Vazgeç',
          ).show(context);
          if (result == true) {
            return exit(0);
          } else {
            return false;
          }
        },
         child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest:
                URLRequest(url: Uri.parse("https://rivlus.com")),
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                initialOptions: options,
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}
