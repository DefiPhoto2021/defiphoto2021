import 'package:flutter/material.dart';
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
  bool selectAll = false;
  bool selection = false;

  final Utilisateur utilisateur;
  List<Utilisateur> liste = List<Utilisateur>.empty(growable: true);
  List<Utilisateur> listeSelection = List<Utilisateur>.empty(growable: true);

  void initState() {
    ajouterUtilisateur();
    super.initState();
  }

  verifierListeSelection(){
    setState(() {
      if (listeSelection.isNotEmpty){
        selection = true;
      } else selection = false;
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
  envoyerQuestion(){
    for (int i = 0; i < listeSelection.length; i++) {
      if (questionCtrl.text != ''){
        Services.addQuestion(utilisateur.id, listeSelection[i].id, questionCtrl.text, type);
        questionCtrl.text = '';
      }
    }

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envoyer une question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: questionCtrl,
              decoration: InputDecoration(hintText: 'Écrivez votre question ici'),
              style: TextStyle(fontSize: 20),
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [creerRadio('M'),creerRadio('É'),creerRadio('T'),creerRadio('I'),creerRadio('E'),creerRadio('R'),]),
            SizedBox(height: 20),
            ElevatedButton(child: Text('Envoyer'), onPressed: selection ? envoyerQuestion: null),
            Text(selection? '': 'Veuillez choisir au moins un destinataire')
          ],
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
