import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
            title: Text("Menu", style: TextStyle(color: Colors.indigo[400])),
            centerTitle: true,
            backgroundColor: Colors.black54,
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.logout,
                  color: Colors.indigo[400],
                ),
                label: Text(
                  "Déconnexion",
                  style: TextStyle(color: Colors.indigo[400]),
                ),
                onPressed: () async {
                  //final action = await Dialog.ouiNonDialog(
                     // context,
                     // "Voulez-vous vous déconnecter?",
                     // "Veuillez sélectionner:");
                },
              )
            ]),
        body: Center(
            child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 50.0,
          crossAxisSpacing: 50.0,
          children: [
            TextButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.indigo[400],
                size: 60.0,
              ),
              label: Text(
                "Profil",
                style: TextStyle(color: Colors.indigo[400]),
              ),
            ),
            TextButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.message_outlined,
                color: Colors.indigo[400],
                size: 60.0,
              ),
              label: Text(
                "Message",
                style: TextStyle(color: Colors.indigo[400]),
              ),
            ),
            TextButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.help,
                color: Colors.indigo[400],
                size: 60.0,
              ),
              label: Text(
                "Aide",
                style: TextStyle(color: Colors.indigo[400]),
              ),
            ),
            TextButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.logout,
                color: Colors.indigo[400],
                size: 60.0,
              ),
              label: Text(
                "Profil",
                style: TextStyle(color: Colors.indigo[400]),
              ),
            ),
          ],
        )));
  }
}
