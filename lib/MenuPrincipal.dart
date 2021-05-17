import 'PageLogin.dart';
import 'Utilisateur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MenuProf.dart';
import 'PageProfil.dart';
import 'PageAide.dart';
import 'MenuEleve.dart';

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
        appBar: AppBar(
            title: Text("Menu"),
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.logout,
                ),
                label: Text(
                  "Déconnexion",
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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children: [
            TextButton.icon(
              onPressed: () {

        Navigator.push(context, MaterialPageRoute(builder : (context) => PageProfil(utilisateur)));
      
      },
              icon: Icon(
                Icons.account_circle_outlined,
                size: 80.0,
              ),
              label: Text(
                "Profil",
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder : (context) => PageAide()));
              },
              icon: Icon(
                Icons.help,
                size: 80.0,
              ),
              label: Text(
                "Aide",
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (utilisateur.type == 'É'){
                  Navigator.push(context, MaterialPageRoute(builder : (context) => MenuEleve(utilisateur)));
                } else if (utilisateur.type == 'P'){
                  Navigator.push(context, MaterialPageRoute(builder : (context) => MenuProf(utilisateur)));
                }
              },
              icon: Icon(
                Icons.more_horiz,
                size: 80.0,
              ),
              label: Text(
                "Plus d'option",
              ),
            ),
          ],
        ));
  }
}
