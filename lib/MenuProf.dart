import 'PageLogin.dart';
import 'PageQuestionProf.dart';
import 'Utilisateur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PageCreationQuestion.dart';
import 'PageListeEleves.dart';

class MenuProf extends StatefulWidget {
  MenuProf(this.utilisateur);
  final Utilisateur utilisateur;
  @override
  _MenuProfState createState() => _MenuProfState(utilisateur);
}

class _MenuProfState extends State<MenuProf> {
  _MenuProfState(this.utilisateur);
  final Utilisateur utilisateur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton.icon(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder : (context) => PageCreerQuestion(utilisateur)));
                  },
                  icon: Icon(
                    Icons.library_add_outlined,
                    size: 80.0,
                  ),
                  label: Text(
                    "Créer questions",
                  ),
                ),
                TextButton.icon(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder : (context) => PageQuestionProf(utilisateur)));
                  },
                  icon: Icon(
                    Icons.library_books_outlined,
                    size: 80.0,
                  ),
                  label: Text(
                    "Gérer questions",
                  ),
                ),
                TextButton.icon(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder : (context) => PageListeEleves(utilisateur)));
                  },
                  icon: Icon(
                    Icons.list_alt_outlined,
                    size: 80.0,
                  ),
                  label: Text(
                    "Liste des étudiants",
                  ),
                ),
                TextButton.icon(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder : (context) => PageListeEleves(utilisateur)));
                  },
                  icon: Icon(
                    Icons.group_add_outlined,
                    size: 80.0,
                  ),
                  label: Text(
                    "Créer utilisateur",
                  ),
                ),
              ],
            ));
  }
}
