import 'package:flutter/material.dart';
import 'package:flutter_app_re/PageCreationProfil.dart';
import 'Services.dart';
import 'Utilisateur.dart';
import 'PageProfil.dart';
import 'PageProgression.dart';
import 'alert_dialog.dart';

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

  naviguerCreationUtilsateur(Utilisateur etudiant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageCreationProfile(etudiant)),
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
              onLongPress: () async {
                final action = await AlertDialogs.yesCancelDialog(context,
                    "Confirmation", "Voulez-vous supprimer ce compte?");
                if (action == DialogsAction.oui) {
                  Services.deleteUtilisateur(liste[i].id)
                      .then((value) => setState(() {
                            liste.remove(liste[i]);
                          }));
                }
              },
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(
                                text: (liste[i].prenom + ' ' + liste[i].nom),
                                style: TextStyle(fontSize: 24),
                                children: [
                              TextSpan(
                                  text: ("#" + liste[i].id),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey))
                            ])),
                      ),
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
              onLongPress: () async {
                final action = await AlertDialogs.yesCancelDialog(context,
                    "Confirmation", "Voulez-vous supprimer ce compte?");
                if (action == DialogsAction.oui) {
                  Services.deleteUtilisateur(liste[i].id)
                      .then((value) => setState(() {
                            liste.remove(liste[i]);
                          }));
                }
              },
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
    listeWidget.add(SizedBox(
      height: 100,
    ));
    return listeWidget;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => naviguerCreationUtilsateur(utilisateur),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Liste des utilisateurs"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: creerCarte()),
      ),
    );
  }
}
