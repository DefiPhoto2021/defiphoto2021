import 'package:flutter/material.dart';


class PageAide extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: Text('Aide'),
                bottom: TabBar(
                  tabs: [Tab(text: 'MÉTIER'), Tab(text: 'Fonctionnement')],
                ),
              ),
              body: TabBarView(children: [
                SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Qu'est-ce que l'acronyme MÉTIER?",
                          style: TextStyle(fontSize: 30, color: Colors.cyan)),
                    ),
                    createExpansionTile('Matières et produits',
                        'Dans cette section, tu devras répondre à des questions posées par ton enseignant par rapport aux produits que tu utilises durant ton stage.'),
                    createExpansionTile('Équipement',
                        'Dans cette section, tu devras répondre à des questions posées par ton enseignant par rapport à l\'équipement que tu utilises durant ton stage.'),
                    createExpansionTile('Tâches et exigences',
                        'Dans cette section, tu devras répondre à des questions posées par ton enseignant par rapport aux tâches que tu exécutes durant ton stage. Tu peux demander à un collègue de te prendre en photo au besoin.'),
                    createExpansionTile('Individu',
                        'Dans cette section, tu devras répondre à des questions posées par ton enseignant par rapport a toi.'),
                    createExpansionTile('Environnement',
                        'Dans cette section, tu devras répondre à des questions posées par ton enseignant par rapport à ton environnement de travail en milieu de stage.'),
                    createExpansionTile('Ressources humaines',
                        'Dans cette section, tu devras répondre à des questions de ressources humaines posées par ton enseignant.')
                  ]),
                ),
                SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Comment fonctionne l'application?",
                          style: TextStyle(fontSize: 30, color: Colors.cyan)),
                    ),
                    createExpansionTile('Page d\'acceuil',
                        'Sur votre page d\'accueil, vous avez accès à votre profil, la page d\'aide, et le bouton « plus d\'option ». Ce dernier donnera accès à différentes options selon l\'utilisateur. Pour les étudiants, il donne accès aux questions et permet de vérifier la progression. Pour les enseignants, c\'est à travers ce bouton que vous aurez accès aux options de créer/gérer des questions, de consulter une liste de vos étudiants et de créer des comptes pour eux.'),
                    createExpansionTile('Se déconnecter',
                        "En appuyant sur l'option «Se déconnecter» dans le menu principal, vous serez déconnecté de l'application.")
                  ]),
                )
              ])),
        );
  }
}

Widget createExpansionTile(String type, String disc) {
  return ExpansionTile(
    title:
    Text(type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          disc,
          style: TextStyle(fontSize: 20),
        ),
      ),
      SizedBox(
        height: 20,
      )
    ],
  );
}