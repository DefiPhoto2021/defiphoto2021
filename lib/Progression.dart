class Progression {
  String id = '';
  String metier= '';
  String metier_rep= '';
  String equipement= '';
  String equipement_rep= '';
  String tache= '';
  String tache_rep= '';
  String individu= '';
  String individu_rep= '';
  String environnement= '';
  String environnement_rep= '';
  String ressource= '';
  String ressource_rep= '';

  Progression({this.id, this.metier, this.metier_rep, this.equipement, this.equipement_rep, this.tache, this.tache_rep, this.individu, this.individu_rep, this.environnement, this.environnement_rep, this.ressource, this.ressource_rep});

  factory Progression.fromJson(Map<String, dynamic> json) {
    print('cool');
    return Progression(
        id: json['id'] as String,
        metier: json['metier'] as String,
        metier_rep: json['metier_rep'] as String,
        equipement: json['equipement'] as String,
        equipement_rep: json['equipement_rep'] as String,
        tache: json['tache'] as String,
        tache_rep: json['tache_rep'] as String,
        individu: json['individu'] as String,
        individu_rep: json['individu_rep'] as String,
        environnement: json['environnement'] as String,
        environnement_rep: json['environnement_rep'] as String,
        ressource: json['ressource'] as String,
        ressource_rep: json['ressource_rep'] as String
    );
  }
}
