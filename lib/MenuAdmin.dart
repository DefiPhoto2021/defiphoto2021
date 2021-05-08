import 'package:flutter_app_re/PageListeUtilisateur.dart';
import 'Utilisateur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuAdmin extends StatefulWidget {
  MenuAdmin(this.utilisateur);
  final Utilisateur utilisateur;
  @override
  _MenuAdmin createState() => _MenuAdmin(utilisateur);
}

class _MenuAdmin extends State<MenuAdmin> {
  _MenuAdmin(this.utilisateur);
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
                        builder: (context) =>
                            PageListeUtilisateur(utilisateur)));
              },
              icon: Icon(
                Icons.insert_chart_outlined,
                size: 60.0,
              ),
              label: Text(
                "Liste des utilisateurs",
              ),
            ),
          ],
        )));
  }
}
