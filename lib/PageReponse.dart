import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'Services.dart';
import 'Utilisateur.dart';
import 'Question.dart';
import 'dart:io';
import 'package:path/path.dart';

class PageReponse extends StatefulWidget {
  PageReponse(this.utilisateur, this.question);
  final Question question;
  final Utilisateur utilisateur;

  @override
  _PageReponse createState() => _PageReponse(utilisateur, question);
}

class _PageReponse extends State<PageReponse> {
  _PageReponse(this.utilisateur, this.question);

  final picker = ImagePicker();
  final Question question;
  final Utilisateur utilisateur;
  final reponseCtrl = TextEditingController();

  File _image;
  String imageName = "aucune";
  String downloadURL = 'null';
  String id = '';
  bool repondu = false;
  bool disbaled = false;

  void initState() {
    verifierReponse();
    super.initState();
  }

  Future getImageGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageName = basename(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageName = basename(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future uploadImageToFirebase(BuildContext context) async {
    downloadURL = 'null';
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    var url = await (await uploadTask).ref.getDownloadURL();
    downloadURL = url.toString();
  }

  verifierReponse() {
    if (int.parse(question.reponse_id) != 0) {
      setState(() {
        repondu = true;
        Services.getReponse(question.reponse_id).then((value) => {
              setState(() {
                reponseCtrl.text = value.reponse;
                disbaled = true;
              })
            });
      });
    }
  }


  envoyer(BuildContext context) async{
    setState(() {
      disbaled = true;
    });
    await uploadImageToFirebase(context);
    trouverID();
    Services.addReponse(
        id, reponseCtrl.text, downloadURL, utilisateur.id, question.type);
    Services.updateQuestionReponse(
      id,
      question.id,
    );
    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 2;
    });
  }

  trouverID() {
    Random random = new Random();
    bool diff = true;
    setState(() {
      id = (random.nextInt(90000) + 10000).toString();
    });
    Services.getReponseListe().then((value) {
      if (value != null) {
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
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Réponse"),
      ),
      floatingActionButton: disbaled ? null : getSpeedDial(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                question.question,
                style: TextStyle(fontSize: 24),
              ),
              TextField(
                enabled: disbaled ? false : true,
                controller: reponseCtrl,
                maxLength: 200,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: 'Écrivez votre réponse ici',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal())),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text("image: " + imageName),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: disbaled ? null : () => envoyer(context),
                  child: Text("Envoyer"))
            ],
          ),
        ),
      ),
    );
  }

  Widget getSpeedDial(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      visible: true,
      curve: Curves.bounceIn,
      overlayOpacity: 0,
      renderOverlay: false,
      children: [
        SpeedDialChild(
          child: Icon(Icons.folder),
          onTap: (() => getImageGallery(context)),
        ),
        SpeedDialChild(
          child: Icon(Icons.camera),
          onTap: () => getImageCamera(context),
        )
      ],
    );
  }
}
