import 'package:flutter/material.dart';
import 'PageCreationQuestion.dart';
import 'Services.dart';
import 'Utilisateur.dart';
import 'Question.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PageReponse extends StatefulWidget {
  PageReponse(this.utilisateur, this.question);
  final Question question;
  final Utilisateur utilisateur;

  @override
  _PageReponse createState() => _PageReponse(utilisateur, question);
}

class _PageReponse extends State<PageReponse> {
  File _image;
  final picker = ImagePicker();
  _PageReponse(this.utilisateur, this.question);
  final Question question;
  final Utilisateur utilisateur;
  final reponseCtrl = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget build(BuildContext context) {
      return Scaffold(appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [Text(question.question, style: TextStyle(fontSize: 24),), TextField(
          controller: reponseCtrl,
          maxLength: 200,
          maxLines: 10,
          decoration: InputDecoration(
              hintText: 'Écrivez votre réponse ici',
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal())),
          style: TextStyle(fontSize: 20),
        )],),
      ),);
  }
}
