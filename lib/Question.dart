class Question {
  String id;
  String id_question;
  String id_prof;
  String id_eleve;
  String question;
  String type;
  String datetime;
  String reponse_id;

  Question(
      {this.id,
      this.id_question,
      this.id_prof,
      this.id_eleve,
      this.question,
      this.type,
      this.datetime,
      this.reponse_id});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json['id'] as String,
        id_question: json['id_question'] as String,
        id_prof: json['id_prof'] as String,
        id_eleve: json['id_eleve'] as String,
        question: json['question'] as String,
        type: json['type'] as String,
        datetime: json['datetime'] as String,
        reponse_id: json['reponse_id'] as String);
  }
}
