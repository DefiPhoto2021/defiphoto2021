import 'package:flutter/material.dart';
import 'dart:math';
import '../Base de données/Services.dart';
import '../Base de données/Utilisateur.dart';

class PageCreerQuestion extends StatefulWidget {
  PageCreerQuestion(this.utilisateur);
  final Utilisateur utilisateur;

  @override
  _PageCreerQuestion createState() => _PageCreerQuestion(utilisateur);
}

class _PageCreerQuestion extends State<PageCreerQuestion> {
  _PageCreerQuestion(this.utilisateur);
  final questionCtrl = TextEditingController();
  String type = 'M';
  String id = '';
  bool selectAll = false;
  bool selection = false;

  final Utilisateur utilisateur;
  List<Utilisateur> liste = List<Utilisateur>.empty(growable: true);
  List<Utilisateur> listeSelection = List<Utilisateur>.empty(growable: true);

  void initState() {
    ajouterUtilisateur();
    super.initState();
  }

  verifierListeSelection() {
    setState(() {
      if (listeSelection.isNotEmpty) {
        selection = true;
      } else
        selection = false;
    });
  }

  ajouterUtilisateur() {
    Services.getUtilisateursListe().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              if (value[i].type == "É")
                {
                  setState(() {
                    liste.add(value[i]);
                  })
                }
            }
        });
  }

  List<Widget> creerRow(StateSetter setState) {
    List<Widget> listeWidget = List<Widget>.empty(growable: true);
    listeWidget
        .add(Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("Tout sélectionner"),
      Checkbox(
          value: selectAll,
          onChanged: (bool value) {
            setState(() {
              listeSelection.clear();
              selectAll = value;
            });
            for (int i = 0; i < liste.length; i++) {
              setState(() {
                if (value) {
                  listeSelection.add(liste[i]);
                }
                liste[i].selection = value;
              });
              verifierListeSelection();
            }
            print(listeSelection.length);
          })
    ]));
    listeWidget.add(Divider());
    if (liste != null) {
      for (int i = 0; i < liste.length; i++) {
        if (liste[i].type == 'É') {
          listeWidget.add(
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                child: Text(liste[i].prenom + ' ' + liste[i].nom,
                    overflow: TextOverflow.fade)),
            Checkbox(
                value: liste[i].selection,
                onChanged: (bool value) {
                  setState(() {
                    if (value) {
                      listeSelection.add(liste[i]);
                    } else {
                      listeSelection.remove(liste[i]);
                      selectAll = false;
                    }
                    liste[i].selection = value;
                  });
                  verifierListeSelection();
                })
          ]));
        }
      }
    }
    return listeWidget;
  }

  envoyerQuestion() {
    trouverID();
    int verification = 0;
    for (int i = 0; i < listeSelection.length; i++) {
      if (questionCtrl.text != '') {
        verification++;
        Services.addQuestion(
            id, utilisateur.id, listeSelection[i].id, questionCtrl.text, type);
      }
    }
    if (verification == listeSelection.length) {
      questionCtrl.text = '';
    }
  }

  trouverID() {
    Random random = new Random();
    bool diff = true;
    setState(() {
      id = (random.nextInt(90000) + 10000).toString();
    });
    Services.getQuestionListe().then((value) {
      do {
        diff = true;
        for (var i = 0; i < value.length; i++) {
          if (id == value[i].id) {
            setState(() {
              id = (random.nextInt(9000) + 1000).toString();
            });
            diff = false;
            break;
          }
        }
      } while (!diff);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envoyer une question'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: questionCtrl,
                  maxLength: 200,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'Écrivez votre question ici',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal())),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: (context, StateSetter setState) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: creerRow(setState),
                              ),
                            ),
                          );
                        });
                      });
                },
                child: Text('Ajouter destinataire(s)'),
              ),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                creerRadio('M'),
                creerRadio('É'),
                creerRadio('T'),
                creerRadio('I'),
                creerRadio('E'),
                creerRadio('R'),
              ]),
              SizedBox(height: 20),
              ElevatedButton(
                  child: Text('Envoyer'),
                  onPressed: selection ? envoyerQuestion : null),
              Text(selection ? '' : 'Veuillez choisir au moins un destinataire')
            ],
          ),
        ),
      ),
    );
  }

  Widget creerRadio(String val) {
    return Column(children: [
      Text(val),
      Radio(
          value: val,
          groupValue: type,
          onChanged: (value) {
            setState(() {
              type = value;
            });
          })
    ]);
  }
}
