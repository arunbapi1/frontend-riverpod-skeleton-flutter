import 'package:architecture_demo/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetUtility {
  static void showAlertDialog(BuildContext context, WidgetRef ref, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                ref.read(alertMessageProvider.notifier).state = null;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
