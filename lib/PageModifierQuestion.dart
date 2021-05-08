import 'package:flutter/material.dart';
import 'Services.dart';
import 'Utilisateur.dart';
import 'Question.dart';
import 'alert_dialog.dart';

class PageModifierQuestion extends StatefulWidget {
  PageModifierQuestion(this.utilisateur, this.question);
  final Utilisateur utilisateur;
  final Question question;

  @override
  _PageModifierQuestion createState() =>
      _PageModifierQuestion(utilisateur, question);
}

class _PageModifierQuestion extends State<PageModifierQuestion> {
  _PageModifierQuestion(this.utilisateur, this.question);
  final Question question;
  final Utilisateur utilisateur;

  final questionCtrl = TextEditingController();
  void modifierQuestion() {
    Services.getQuestionListe().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              if (value[i].id_question == question.id_question)
                {
                  Services.updateQuestionText(questionCtrl.text, value[i].id),
                }
            }
        });
    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 2;
    });
  }

  Future<void> supprimerQuestion() async {
    final action = await AlertDialogs.yesCancelDialog(
        context, "Confirmation", "Voulez-vous supprimer cette question?");
    if (action == DialogsAction.oui) {
      Services.getQuestionListe().then((value) => {
            for (int i = 0; i < value.length; i++)
              {
                if (value[i].id_question == question.id_question)
                  {
                    if (value[i].reponse_id == '0')
                      {
                        Services.deleteQuestion(value[i].id, value[i].type,
                            value[i].id_eleve, value[i].reponse_id,'false'),
                      }
                    else
                      {
                        Services.deleteQuestion(value[i].id, value[i].type,
                            value[i].id_eleve,value[i].reponse_id ,'true'),
                      }
                  }
              }
          });
      int count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
    }
  }

  Widget build(BuildContext context) {
    questionCtrl.text = question.question;
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la question'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: modifierQuestion, child: Text('Modifier')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                onPressed: supprimerQuestion,
                child: Text('Supprimer'))
          ],
        ),
      ),
    );
  }
}
