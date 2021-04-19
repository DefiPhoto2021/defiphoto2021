import 'package:flutter/material.dart';

enum DialogsAction {oui, non}

class Dialog{
  static Future<DialogsAction> ouiNonDialog(
      BuildContext context,
      String title,
      String body,
      )
      async{
        final action = await showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(10),
                ),
                    title: Text(title),
                    content: Text(body),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(DialogsAction.non),
                        child: const Text("Non"),
              ),
                      RaisedButton(
                        onPressed: () => Navigator.of(context).pop(DialogsAction.oui),
                        child: const Text("Oui"),
              ),
              ]
              );
            },
        );
        return(action != null) ? action: DialogsAction.non;
      }
}