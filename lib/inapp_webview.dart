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
  InAppWebViewController? _webViewController;
  double progress = 0;

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
          body: Column(
            children: <Widget>[
              Expanded(
                child: InAppWebView(
                  gestureRecognizers: Set()
                    ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer()
                          ..onDown = (DragDownDetails dragDownDetails) {
                            _webViewController!.getScrollY().then((value) {
                              if (value == 0 &&
                                  dragDownDetails.globalPosition.direction <
                                      1) {

                                _webViewController!.reload();
                              }
                            });
                          })),
                  initialUrlRequest:
                      URLRequest(url: Uri.parse("https://rivlus.com")),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
