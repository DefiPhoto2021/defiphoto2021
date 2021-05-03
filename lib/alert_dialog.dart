import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum DialogsAction {oui, non}

class AlertDialogs{
  static Future<DialogsAction> yesCancelDialog(
      BuildContext context,
      String titre,
      String description,
      ) async {
    final action =  await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.black38,
            title: Text(titre),
            content: Text(description),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(DialogsAction.non),
                  child: Text(
                      "Non",
                  style: TextStyle(
                    color: Colors.indigo[400],
                    fontWeight: FontWeight.bold
                  ),
                  ),
              ),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(DialogsAction.oui),
                  child: Text(
                      "Oui",
                  style: TextStyle(
                    color: Colors.indigo[400],
                    fontWeight: FontWeight.bold
                  )
                  ),
              )
            ],
          );
        },
    );
    return (action!=null) ? action : DialogsAction.non;
  }
}