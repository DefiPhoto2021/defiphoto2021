import 'package:flutter/material.dart';
import 'Services.dart';
import 'Utilisateur.dart';
import 'PageProfil.dart';
import 'PageProgression.dart';

class PageListeUtilisateur extends StatefulWidget {
  PageListeUtilisateur(this.utilisateur);
  final Utilisateur utilisateur;

  @override
  _PageListeUtilisateur createState() => _PageListeUtilisateur(utilisateur);
}

class _PageListeUtilisateur extends State<PageListeUtilisateur> {
  _PageListeUtilisateur(this.utilisateur);

  final Utilisateur utilisateur;
  List<Utilisateur> liste = List<Utilisateur>.empty(growable: true);

  void initState() {
    ajouterUtilisateur();
    super.initState();
  }

  ajouterUtilisateur() {
    Services.getUtilisateursListe().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              if (value[i].type != "A")
                {
                  setState(() {
                    liste.add(value[i]);
                  })
                }
            }
        });
  }

  naviguerProfileEtudiant(Utilisateur etudiant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageProfil(etudiant)),
    );
  }

  naviguerProgresEtudiant(Utilisateur etudiant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageProgression(etudiant)),
    );
  }

  showAlertDialog(BuildContext context, Utilisateur user) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Non"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Oui"),
      onPressed: () {
        Navigator.of(context).pop();
        Services.deleteUtilisateur(user.id).then((value) => setState(() {
              liste.remove(user);
            }));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Voulez-vous supprimer ce compte?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Widget> creerCarte() {
    List<Widget> listeWidget = List<Widget>.empty(growable: true);
    if (liste != null) {
      for (int i = 0; i < liste.length; i++) {
        if (liste[i].type == 'É') {
          listeWidget.add(Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: GestureDetector(
              onLongPress: () => showAlertDialog(context, liste[i]),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          text: TextSpan(
                              text: (liste[i].prenom + ' ' + liste[i].nom),
                              style: TextStyle(fontSize: 24),
                              children: [
                            TextSpan(
                                text: ("#" + liste[i].id),
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey))
                          ])),
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.account_circle),
                            onPressed: () => naviguerProfileEtudiant(liste[i])),
                        IconButton(
                            icon: Icon(Icons.bar_chart),
                            onPressed: () => naviguerProgresEtudiant(liste[i]))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ));
        } else {
          listeWidget.add(Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: GestureDetector(
              onLongPress: () => showAlertDialog(context, liste[i]),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          text: TextSpan(
                              text: (liste[i].prenom + ' ' + liste[i].nom),
                              style: TextStyle(fontSize: 24),
                              children: [
                            TextSpan(
                                text: ("#" + liste[i].id),
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey))
                          ])),
                    ),
                  ],
                ),
              ),
            ),
          ));
        }
      }
    }
    return listeWidget;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des utilisateurs")),
      body: SingleChildScrollView(
        child: Column(
          children: creerCarte(),
        ),
      ),
    );
  }
}
