import 'Question.dart';
import 'package:flutter/material.dart';
import 'PageCreationQuestion.dart';
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

  void initState() {
    ajouterQuestion();
    super.initState();
  }

  ajouterQuestion() {
    liste.clear();
    Services.getQuestionListe().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              setState(() {
                liste.add(value[i]);
              })
            }
        });
  }

  List<Widget> creerCarte(String type) {
    print(liste.length);
    List<Widget> listeWidget = List<Widget>.empty(growable: true);
    if (liste.isNotEmpty) {
      for (int i = 0; i < liste.length; i++) {
        if (i == 0) {
          if (liste[i].type == type) {
            dateTimeCalcString(liste[i].datetime);
            listeWidget.add(creerTexte(liste[i]));
          }
        } else if (liste[i].id != liste[i - 1].id) {
          if (liste[i].type == type) {
            dateTimeCalcString(liste[i].datetime);
            listeWidget.add(creerTexte(liste[i]));
          }
        }
      }
    }
    return listeWidget;
  }

  Widget creerTexte(Question question) {
    return Padding(
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
                          style: TextStyle(fontSize: 14, color: Colors.grey)),Row(children: [IconButton(onPressed: null, icon: Icon(Icons.mode_edit))],),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  void dateTimeCalcString(String value) {
    DateTime datetime = DateTime.parse(value);
    Duration diff = DateTime.now().difference(datetime);
    setState(() {
      if ((diff.inDays / 365).floor() > 0) {
        valeurTemps =
            'Il y a ' + (diff.inDays / 365).floor().toString() + ' an(s)';
      } else if ((diff.inDays / 30).floor() > 0) {
        valeurTemps =
            'Il y a ' + (diff.inDays / 30).floor().toString() + ' mois';
      } else if ((diff.inDays).floor() > 0) {
        valeurTemps = 'Il y a ' + (diff.inDays).floor().toString() + ' jour(s)';
      } else if ((diff.inHours).floor() > 0) {
        valeurTemps =
            'Il y a ' + (diff.inHours).floor().toString() + ' heure(s)';
      } else if ((diff.inMinutes).floor() > 0) {
        valeurTemps =
            'Il y a ' + (diff.inMinutes).floor().toString() + ' minute(s)';
      } else if ((diff.inSeconds).floor() > 0) {
        valeurTemps =
            'Il y a ' + (diff.inSeconds).floor().toString() + ' seconde(s)';
      }
    });
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

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
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
