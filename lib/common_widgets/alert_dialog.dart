import 'dart:io';
import 'platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CommonAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String mainButtonText;
  final String cancelButtonText;

  const CommonAlertDialog({
    required this.title,
    required this.content,
    required this.mainButtonText,
    required this.cancelButtonText,
  });

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
        context: context, builder: (context) => this)
        : await showDialog(
        context: context,
        builder: (context) => this,
        barrierDismissible: false);
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _diaglogButtons(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _diaglogButtons(context),
    );
  }

  List<Widget> _diaglogButtons(BuildContext context) {
    final allButtons = <Widget>[];
    if (Platform.isIOS) {
      if (cancelButtonText != null) {
        allButtons.add(
          CupertinoDialogAction(
            child: Text(cancelButtonText),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }

      allButtons.add(
        CupertinoDialogAction(
          child: Text(mainButtonText),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    } else {
      if (cancelButtonText != null) {
        allButtons.add(
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(cancelButtonText)),
        );
      }

      allButtons.add(
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(mainButtonText)),
      );
    }
    return allButtons;
  }
}