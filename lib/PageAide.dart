import 'package:flutter/material.dart';


class PageAide extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          accentColor: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: DefaultTabController(
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
                        'Sur ta page d\'accueil, tu peux voir ta progression pour chaque catégorie (MÉTIER) ainsi que ta progression totale. La progression représente le pourcentage de question auxquelles tu as répondu.'),
                    createExpansionTile('Navigation',
                        'Pour naviguer dans l\'application, tu dois utiliser le menu hamburger qui est disponible en haut à gauche de ta page d\'accueil. Dans ce menu, tu verras toutes les sections de l\'application auxquelles tu as accès.'),
                    createExpansionTile(
                        'Questions de stage',
                        'En appuyant sur l\'option «Question de stage» dans ton menu, tu arriveras sur une page avec les catégories de l\'acronyme MÉTIER. En cliquant sur une catégorie, la page t\'affichera les questions '
                            'que ton enseignant t\'a posé pour cette catégorie.  Si tu appuies sur l\'icone de volume d\'une question, tu pourras entendre celle-ci. Pour répondre à la question tu dois appuyer sur celle-ci.'),
                    createExpansionTile(
                        'Page des commentaires',
                        "En appuyant sur une question, tu seras amené sur la page des commentaires. Sur cette page, tu pourras répondre à la question de ton enseignant. S'il te demande d'envoyer des photos, tu peux "
                            "le faire en choisissant des photos de ta galerie ou en prenant la photo directement dans l'application. Pour envoyer un message vocal, tu dois appuyer sur l'icône du microphone. En appuyant une fois, tu activeras le microphone et en "
                            "cliquant une deuxième fois, tu désactiveras le microphone et ton message s'enverra automatiquement au professeur."),
                    createExpansionTile(
                        'Poser des questions',
                        "En appuyant sur l'option «Poser des questions» dans ton menu, tu arriveras sur une page ou tes questions posées seront affichées. Si tu n'en as pas encore posé, la page sera vide. Pour poser "
                            "une question à ton enseignant, tu dois appuyer sur le bouton «+» en bas à droite de ton écran, ceci t'amènera sur une nouvelle page. Dans cette nouvelle page, tu peux écrire la question que tu as à poser et indiquer dans quelle catégorie elle se situe. "),
                    createExpansionTile('Profil',
                        'En appuyant sur l\'option «Profil» dans ton menu, tu accèderas à toutes tes informations.'),
                    createExpansionTile('Se déconnecter',
                        "En appuyant sur l'option «Se déconnecter» dans ton menu, tu seras déconnecté de l'application.")
                  ]),
                )
              ])),
        ));
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
