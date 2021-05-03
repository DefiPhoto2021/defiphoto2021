import 'package:defiphoto2021/PageLogin.dart';
import 'package:defiphoto2021/Utilisateur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:defiphoto2021/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                    Navigator.pushNamed(context, '/progression');
                  },
                  icon: Icon(
                    Icons.insert_chart_outlined,
                    color: Colors.indigo[400],
                    size: 60.0,
                  ),
                  label: Text(
                    "Progression",
                    style: TextStyle(color: Colors.indigo[400]),
                  ),
                ),
                TextButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.list,
                    color: Colors.indigo[400],
                    size: 60.0,
                  ),
                  label: Text(
                    "Questions",
                    style: TextStyle(color: Colors.indigo[400]),
                  ),
                ),

              ],
            )));
  }
}
