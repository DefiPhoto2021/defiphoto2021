import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum DialogsAction { oui, non }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String titre,
    String description,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titre),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.non),
              child: Text(
                "Non",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.oui),
              child: Text("Oui", style: TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.non;
  }
}
