import 'package:defiphoto2021/PageLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:defiphoto2021/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:defiphoto2021/Utilisateur.dart';

class MenuPrincipal extends StatefulWidget {
  MenuPrincipal(this.utilisateur);
  final Utilisateur utilisateur;
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState(utilisateur);
}

class _MenuPrincipalState extends State<MenuPrincipal> {

  _MenuPrincipalState(this.utilisateur);
  final Utilisateur utilisateur;

  bool tappedYes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black38,
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
                onPressed: () async{
                  final action =  await AlertDialogs.yesCancelDialog(context, "Déconnexion", "Voulez-vous vous déconnecter?");
                  if (action == DialogsAction.oui){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('id');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) => PageLogin()));
                  }
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
