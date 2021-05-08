import 'package:flutter/material.dart';

import 'Question.dart';
import 'Services.dart';
import 'Utilisateur.dart';

class PageReponseProf extends StatefulWidget {
  PageReponseProf(this.utilisateur, this.question);
  final Utilisateur utilisateur;
  final Question question;

  @override
  _PageReponseProf createState() => _PageReponseProf(utilisateur, question);
}

class _PageReponseProf extends State<PageReponseProf> {
  _PageReponseProf(this.utilisateur, this.question);
  final Utilisateur utilisateur;
  final Question question;

  List<Utilisateur> liste = List<Utilisateur>.empty(growable: true);
  List<String> listeRep = List<String>.empty(growable: true);
  List<String> listeImage = List<String>.empty(growable: true);
  void initState() {
    ajouterEtudiant();
    super.initState();
  }

  ajouterEtudiant() {
    Services.getUtilisateursListe().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              Services.getQuestionListe().then((_value) => {
                    for (int j = 0; j < _value.length; j++)
                      {
                        if (value[i].id_prof == utilisateur.id &&
                            _value[j].id_eleve == value[i].id &&
                            _value[j].id_question == question.id_question)
                          {
                            setState(() {
                              liste.add(value[i]);
                              setReponse(question.id_question, value[i].id,
                                  liste.length - 1);
                            })
                          }
                      }
                  })
            }
        });
  }

  void setReponse(String id_question, String id_eleve, int j) {
    int verification = 0;
    Services.getQuestionListe().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              if (value[i].id_question == id_question &&
                  value[i].id_eleve == id_eleve &&
                  value[i].reponse_id != '0')
                {
                  Services.getReponse(value[i].reponse_id).then((rep) => {
                        if (rep.reponse != null)
                          {
                            setState(() {
                              listeRep[j] = rep.reponse;
                              if (rep.image_name != 'null') {
                                listeImage[j] = rep.image_name;
                              } else
                                listeImage[j] = 'Pas de image';
                            }),
                            verification++
                          }
                      })
                }
            },
        });
    if (verification == 0) {
      listeImage.add('Pas de image');
      listeRep.add('Pas de réponse');
    }
  }

  List<Widget> creerCarte() {
    List<Widget> listeWidget = List<Widget>.empty(growable: true);
    bool repondu = false;
    bool image = false;
    if (liste != null) {
      for (int i = 0; i < liste.length; i++) {
        if (listeRep[i] == 'Pas de réponse') {
          repondu = true;
        } else
          repondu = false;
        if (listeImage[i] != 'Pas de image') {
          image = true;
        } else
          image = false;
        listeWidget.add(Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ajouterImage(i, repondu, image),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }
    listeWidget.add(SizedBox(
      height: 100,
    ));
    return listeWidget;
  }

  List<Widget> ajouterImage(int i, bool repondu, bool image) {
    List<Widget> listeWidget = List<Widget>.empty(growable: true);
    listeWidget.add(RichText(
      text: TextSpan(
        text: (liste[i].prenom + ' ' + liste[i].nom),
        style: TextStyle(fontSize: 16, color: Colors.white70),
      ),
    ));
    listeWidget.add(SizedBox(
      height: 10,
    ));
    listeWidget.add(
      Text(listeRep[i],
          style: TextStyle(
              fontSize: 18, color: repondu ? Colors.redAccent : Colors.cyan)),
    );
    if (image){
      listeWidget.add(Image.network(listeImage[i]));
    }
    
    return listeWidget;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réponses"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: creerCarte(),
        ),
      ),
    );
  }
}
