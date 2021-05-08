import 'package:flutter_app_re/CalculTemps.dart';

import 'PageReponse.dart';
import 'package:flutter/material.dart';
import 'Services.dart';
import 'Utilisateur.dart';
import 'Question.dart';

class PageQuestionEleve extends StatefulWidget {
  PageQuestionEleve(this.utilisateur);
  final Utilisateur utilisateur;

  @override
  _PageQuestionEleve createState() => _PageQuestionEleve(utilisateur);
}

class _PageQuestionEleve extends State<PageQuestionEleve> {
  _PageQuestionEleve(this.utilisateur);
  final Utilisateur utilisateur;
  String valeurTemps = '';
  List<Question> liste = List<Question>.empty(growable: true);

  void initState() {
    ajouterQuestion();
    super.initState();
  }

  ajouterQuestion() {
    liste.clear();
    Services.getQuestionListe().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              if (value[i].id_eleve == utilisateur.id)
                {
                  setState(() {
                    liste.add(value[i]);
                  })
                }
            }
        });
  }

  List<Widget> creerCarte(String type) {
    List<Widget> listeWidget = List<Widget>.empty(growable: true);
    if (liste.isNotEmpty) {
      for (int i = 0; i < liste.length; i++) {
        if (liste[i].type == type) {
          valeurTemps = CalculTemps.dateTimeCalcString(liste[i].datetime);
          listeWidget.add(creerTexte(liste[i]));
        }
      }
    }
    return listeWidget;
  }

  naviguerCreationQuestion(Question question) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PageReponse(utilisateur, question)),
    );
  }

  Widget creerTexte(Question question) {
    return GestureDetector(
      onTap: () => naviguerCreationQuestion(question),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: verifierReponse(question)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget verifierReponse(Question question) {
    if (int.parse(question.reponse_id) == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question.question, style: TextStyle(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(valeurTemps,
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_box_outline_blank,
            color: Colors.red,
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question.question, style: TextStyle(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(valeurTemps,
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_box,
            color: Colors.green,
          )
        ],
      );
    }
  }

  Widget creerTab(String type) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: creerCarte(type),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Questions'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'M'),
              Tab(text: 'É'),
              Tab(text: 'T'),
              Tab(text: 'I'),
              Tab(text: 'E'),
              Tab(text: 'R')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            creerTab('M'),
            creerTab('É'),
            creerTab('T'),
            creerTab('I'),
            creerTab('E'),
            creerTab('R'),
          ],
        ),
      ),
    );
  }
}
