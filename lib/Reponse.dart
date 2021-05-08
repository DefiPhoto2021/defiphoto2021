class Reponse {
  String id;
  String reponse;
  String image_name;
  String id_eleve;

  Reponse({this.id, this.reponse, this.image_name, this.id_eleve});

  factory Reponse.fromJson(Map<String, dynamic> json) {
    return Reponse(
      id: json['id'] as String,
      reponse: json['reponse'] as String,
      image_name: json['image_name'] as String,
      id_eleve: json['id_eleve'] as String,
    );
  }
}
