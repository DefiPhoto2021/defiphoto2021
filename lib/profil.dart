import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
        backgroundColor: Colors.indigo[700],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 70,
                ),
                Text(
                  '(prénom + nom)',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.message_outlined,
                  size: 50,
                  color: Colors.cyan[100],
                ),
              ],
            ),
            Divider(
              height: 50.0,
              color: Colors.white,
            ),
            Text(
              'MÉTIER',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ENSEIGNANT',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ENTREPRISE',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 50.0,
              color: Colors.white,
            ),
            Text(
              'PROGRESSION (insérer progression en dessous)',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
