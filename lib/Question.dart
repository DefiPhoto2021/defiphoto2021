class Question {
  String id;
  String id_prof;
  String id_eleve;
  String question;
  String type;
  String datetime;


  Question({this.id, this.id_prof, this.id_eleve, this.question, this.type, this.datetime});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      id_prof: json['id_prof'] as String,
      id_eleve: json['id_eleve'] as String,
      question: json['question'] as String,
      type: json['type'] as String,
      datetime: json['datetime'] as String
    );
  }
}