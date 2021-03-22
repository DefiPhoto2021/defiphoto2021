class Utilisateur {
  String id;
  String user;
  String pass;
  String type;

  Utilisateur({this.id, this.user, this.pass, this.type});

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'] as String,
      user: json['username'] as String,
      pass: json['password'] as String,
      type: json['type'] as String
    );
  }
}
