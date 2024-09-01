import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showAppDialog(BuildContext context,
    String title, String content,
    Function? onTap) {
  return Platform.isIOS
    ? showCupertinoDialog(
    context: context,
    builder: (BuildContext ctx) {
      return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("Not now"),
              onPressed: () {
                Navigator.of(ctx, rootNavigator: true).pop();
              },
            ),
              CupertinoDialogAction(
                  child: const Text("Proceed"),
                  onPressed: () {
                    Navigator.of(ctx, rootNavigator: true).pop();
                    onTap?.call();
                  })
          ]);
    }) : showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed:  () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            onPressed: () {
              onTap?.call();
              Navigator.pop(context);
            },
            child: const Text("Proceed"),
          ),
        ],
      );
    },
  );
}