import 'package:flutter/material.dart';
import 'dart:math';
import 'Services.dart';
import 'Utilisateur.dart';

class PageCreationProfile extends StatefulWidget {
  PageCreationProfile(this.utilisateur);
  final Utilisateur utilisateur;
  @override
  _PageCreationProfile createState() => _PageCreationProfile(utilisateur);
}

class _PageCreationProfile extends State<PageCreationProfile> {
  _PageCreationProfile(this.utilisateur);
  final Utilisateur utilisateur;
  String id = '';
  String type = 'É';
  bool prof = false;
  final nomCtrl = TextEditingController();
  final prenomCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final profCtrl = TextEditingController();
  final stageCtrl = TextEditingController();

  void initState() {
    trouverID();
    super.initState();
  }

  trouverID() {
    Random random = new Random();
    bool diff = true;
    setState(() {
      id = (random.nextInt(9000) + 1000).toString();
    });
    Services.getUtilisateursListe().then((value) {
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

  void createUser() {
    //var hashedPassword = Crypt.sha512(passCtrl.text).toString();
    if (type == 'É') {
      if (nomCtrl.text != '' &&
          prenomCtrl.text != '' &&
          passCtrl.text.length >= 6 &&
          profCtrl.text != '' &&
          stageCtrl.text != '') {
        Services.addUtilisateur(id, nomCtrl.text, prenomCtrl.text,
            passCtrl.text, type, profCtrl.text, stageCtrl.text);
        nomCtrl.clear();
        prenomCtrl.clear();
        passCtrl.clear();
        profCtrl.clear();
        stageCtrl.clear();
        setState(() {
          trouverID();
        });
      }
    } else if (nomCtrl.text != '' &&
        prenomCtrl.text != '' &&
        passCtrl.text.length >= 6) {
      Services.addUtilisateur(
          id, nomCtrl.text, prenomCtrl.text, passCtrl.text, type, '0', 'null');
      nomCtrl.clear();
      prenomCtrl.clear();
      passCtrl.clear();
      profCtrl.clear();
      stageCtrl.clear();
      setState(() {
        trouverID();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (utilisateur.type == 'P') {
      prof = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un nouveau compte'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Text(
              ('ID: ' + id),
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                creerRadio('É', 'Étudiant'),
                creerRadio('P', 'Professeur'),
                creerRadio('A', 'Admin')
              ],
            ),
            creerTextField('Nom', nomCtrl),
            SizedBox(height: 20),
            creerTextField('Prénom', prenomCtrl),
            SizedBox(height: 20),
            TextFormField(
              controller: passCtrl,
              autovalidateMode: AutovalidateMode.always,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
              validator: (String value) {
                return (value.length < 6 && value.length != 0)
                    ? 'Le mot de passe doit contenir au moins 6 caractères'
                    : null;
              },
            ),
            SizedBox(height: 20),
            creerTextField("ID de l'enseignant", profCtrl),
            SizedBox(height: 20),
            creerTextField('Nom du stage', stageCtrl),
            SizedBox(height: 20),
            ElevatedButton(onPressed: createUser, child: Text('Créer'))
          ]),
        ),
      ),
    );
  }

  Widget creerTextField(String indice, TextEditingController ctrl) {
    bool _enabled = true;
    bool lineThru = true;
    if ((indice == "ID de l'enseignant" || indice == "Nom du stage") &&
        (type == 'P' || type == 'A')) {
      setState(() {
        lineThru = false;
        _enabled = false;
      });
    } else if (prof && indice == "ID de l'enseignant") {
      setState(() {
        _enabled = false;
      });
    } else {
      setState(() {
        _enabled = true;
      });
    }
    if (prof) {
      profCtrl.text = utilisateur.id;
    }

    return TextField(
      style: TextStyle(fontSize: 24),
      controller: ctrl,
      decoration: InputDecoration(
          enabled: _enabled ? true : false,
          labelText: indice,
          labelStyle: lineThru
              ? null
              : TextStyle(decoration: TextDecoration.lineThrough)),
    );
  }

  Widget creerRadio(String val, String nom) {
    return Column(children: [
      Text(nom),
      Radio(
          value: val,
          groupValue: type,
          onChanged: (value) {
            if (value != 'É') {
              profCtrl.clear();
              stageCtrl.clear();
            }
            setState(() {
              type = value;
            });
          })
    ]);
  }
}
