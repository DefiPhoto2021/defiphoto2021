import 'package:defiphoto2021/PageLogin.dart';
import 'package:defiphoto2021/Utilisateur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.black38,
        appBar: AppBar(
          title: Text("Menu", style: TextStyle(color: Colors.indigo[400])),
          centerTitle: true,
          backgroundColor: Colors.black54,
          elevation: 0.0,
        ),
        body: Center(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 50.0,
              crossAxisSpacing: 50.0,
              children: [
                TextButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, '/creerQuestion');
                  },
                  icon: Icon(
                    Icons.library_add_outlined,
                    color: Colors.indigo[400],
                    size: 60.0,
                  ),
                  label: Text(
                    "Créer questions",
                    style: TextStyle(color: Colors.indigo[400]),
                  ),
                ),
                TextButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, '/questionProf');
                  },
                  icon: Icon(
                    Icons.library_books_outlined,
                    color: Colors.indigo[400],
                    size: 60.0,
                  ),
                  label: Text(
                    "Gérer questions",
                    style: TextStyle(color: Colors.indigo[400]),
                  ),
                ),
                TextButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, '/listeEleves');
                  },
                  icon: Icon(
                    Icons.list_alt_outlined,
                    color: Colors.indigo[400],
                    size: 60.0,
                  ),
                  label: Text(
                    "Liste des étudiants",
                    style: TextStyle(color: Colors.indigo[400]),
                  ),
                ),
              ],
            )));
  }
}
