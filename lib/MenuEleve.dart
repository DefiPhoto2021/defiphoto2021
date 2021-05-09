import 'package:flutter_app_re/PageQuestionEleve.dart';
import 'PageProgression.dart';
import 'Utilisateur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuEleve extends StatefulWidget {
  MenuEleve(this.utilisateur);
  final Utilisateur utilisateur;
  @override
  _MenuEleveState createState() => _MenuEleveState(utilisateur);
}

class _MenuEleveState extends State<MenuEleve> {
  _MenuEleveState(this.utilisateur);
  final Utilisateur utilisateur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Menu",
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
            child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 50.0,
          crossAxisSpacing: 50.0,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageProgression(utilisateur)));
              },
              icon: Icon(
                Icons.insert_chart_outlined,
                size: 50.0,
              ),
              label: Text(
                "Progression",
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageQuestionEleve(utilisateur)));
              },
              icon: Icon(
                Icons.list,
                size: 60.0,
              ),
              label: Text(
                "Questions",
              ),
            ),
          ],
        )));
  }
}
