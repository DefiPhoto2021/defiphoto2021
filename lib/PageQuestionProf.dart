import 'package:flutter/material.dart';
import 'package:flutter_app_re/PageModifierQuestion.dart';
import 'CalculTemps.dart';
import 'PageCreationQuestion.dart';
import 'PageReponseProf.dart';
import 'Services.dart';
import 'Utilisateur.dart';
import 'Question.dart';

class PageQuestionProf extends StatefulWidget {
  PageQuestionProf(this.utilisateur);
  final Utilisateur utilisateur;

  @override
  _PageQuestionProf createState() => _PageQuestionProf(utilisateur);
}

class _PageQuestionProf extends State<PageQuestionProf> {
  _PageQuestionProf(this.utilisateur);
  final Utilisateur utilisateur;
  String valeurTemps = '';

  List<Question> liste = List<Question>.empty(growable: true);
  List<int> listeReponse = List<int>.empty(growable: true);

  void initState() {
    ajouterQuestion();
    super.initState();
  }

  ajouterQuestion() {
    liste.clear();
    Services.getQuestionListe().then((value) => {
          if (value != null)
            {
              for (int i = 0; i < value.length; i++)
                {
                  setState(() {
                    liste.add(value[i]);
                    if (value[i].reponse_id != '0') {
                      listeReponse.add(1);
                    } else
                      listeReponse.add(0);
                  })
                }
            }
        });
  }

  List<Widget> creerCarte(String type) {
    List<Widget> listeWidget = List<Widget>.empty(growable: true);
    if (liste.isNotEmpty) {
      for (int i = 0; i < liste.length; i++) {
        if (i == 0) {
          if (liste[i].type == type) {
            valeurTemps = CalculTemps.dateTimeCalcString(liste[i].datetime);
            listeWidget.add(creerTexte(liste[i]));
          }
        } else if (liste[i].id_question != liste[i - 1].id_question) {
          if (liste[i].type == type) {
            valeurTemps = CalculTemps.dateTimeCalcString(liste[i].datetime);
            listeWidget.add(creerTexte(liste[i]));
          }
        }
      }
    }
    return listeWidget;
  }

  naviguerPageReponseProf(Utilisateur etudiant, Question question) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PageReponseProf(utilisateur, question)),
    );
  }

  Widget creerTexte(Question question) {
    return GestureDetector(
      onTap: () => naviguerPageReponseProf(utilisateur, question),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                        Row(
                          children: [
                            IconButton(
                                onPressed: () =>
                                    naviguerModifierQuestion(question),
                                icon: Icon(Icons.mode_edit))
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
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

  naviguerCreationQuestion() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageCreerQuestion(utilisateur)),
    ).then((value) => setState(() {
          ajouterQuestion();
        }));
  }

  naviguerModifierQuestion(Question question) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PageModifierQuestion(utilisateur, question)),
    ).then((value) => setState(() {
          ajouterQuestion();
        }));
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
        floatingActionButton: FloatingActionButton(
          onPressed: naviguerCreationQuestion,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
