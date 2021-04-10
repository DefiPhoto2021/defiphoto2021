import 'package:flutter/material.dart';
import '../Base de données/Utilisateur.dart';
import '../Base de données/Services.dart';

class PageProfil extends StatefulWidget {
  PageProfil(this.etudiant);
  final Utilisateur etudiant;

  @override
  _PageProfil createState() => _PageProfil(etudiant);
}

class _PageProfil extends State<PageProfil> {
  final Utilisateur etudiant;
  _PageProfil(this.etudiant);
  String nomProf = '';
  void initState() {
      getNomProf(etudiant.id_prof);
      super.initState();
  }

  getNomProf(String id) {
    Services.getUtilisateur(id).then((value) {
      if (value != null) {
        setState(() {
          nomProf = (value.prenom + " " + value.nom);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 20),
                creerRow('ID', etudiant.id),
                SizedBox(height: 20),
                creerRow('Nom', etudiant.nom),
                SizedBox(height: 20),
                creerRow('Prénom', etudiant.prenom),
                SizedBox(height: 20),
                creerRow('Enseignant', nomProf),
                SizedBox(height: 20),
                creerRow('Stage', etudiant.nom_stage),
          ]),
        ));
  }

  Widget creerRow(String type, String _var) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(type + ':', style: TextStyle(fontSize: 22)),
      Text(_var, style: TextStyle(fontSize: 26))
    ]);
  }
}
