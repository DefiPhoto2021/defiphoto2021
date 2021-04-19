class Utilisateur {
  String id;
  String nom;
  String prenom;
  String type;
  String password;
  String id_prof;
  String nom_stage;

  bool selection = false; //Utiliser pour choisir les destinataires

  Utilisateur({this.id, this.nom, this.prenom, this.type, this.password, this.id_prof, this.nom_stage});

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'] as String,
        nom: json['nom'] as String,
        prenom: json['prenom'] as String,
        type: json['type'] as String,
        password: json['password'] as String,
        id_prof: json['id_prof'] as String,
        nom_stage: json['nom_stage'] as String
    );
  }
}
