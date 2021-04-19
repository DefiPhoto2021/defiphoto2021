import 'package:flutter/material.dart';
import 'Utilisateur.dart';
import 'Progression.dart';
import 'Services.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PageProgression extends StatefulWidget {
  PageProgression(this.etudiant);
  final Utilisateur etudiant;

  @override
  _PageProgression createState() => _PageProgression(etudiant);
}

class _PageProgression extends State<PageProgression> {
  _PageProgression(this.etudiant);
  final Utilisateur etudiant;
  Progression prog = new Progression( //J'initialise avec des valeurs temporaires
      id: '1',
      metier: '1',
      metier_rep: '1',
      equipement: '1',
      equipement_rep: '1',
      tache: '1',
      tache_rep: '1',
      individu: '1',
      individu_rep: '1',
      environnement: '1',
      environnement_rep: '1',
      ressource: '1',
      ressource_rep: '1');

  void initState() {
    getProgression(etudiant.id);
    super.initState();
  }

  getProgression(String id) {
    Services.getProgression(id).then((value) => {
          if (value != null)
            {
              setState(() {
                prog = value;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progression')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Progression par catégorie',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      colonneType('M'),
                      colonneType('É'),
                      colonneType('T'),
                      colonneType('I'),
                      colonneType('E'),
                      colonneType('R'),
                    ],
                  ),
                  Column(
                    children: [
                      colonneBarre(prog.metier_rep, prog.metier),
                      colonneBarre(prog.equipement_rep, prog.equipement),
                      colonneBarre(prog.tache_rep, prog.tache),
                      colonneBarre(prog.individu_rep, prog.individu),
                      colonneBarre(prog.environnement_rep, prog.environnement),
                      colonneBarre(prog.ressource_rep, prog.ressource),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      colonnePourcentage(prog.metier_rep, prog.metier),
                      colonnePourcentage(prog.equipement_rep, prog.equipement),
                      colonnePourcentage(prog.tache_rep, prog.tache),
                      colonnePourcentage(prog.individu_rep, prog.individu),
                      colonnePourcentage(prog.environnement_rep, prog.environnement),
                      colonnePourcentage(prog.ressource_rep, prog.ressource),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Progression totale',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              CircularPercentIndicator(
                  radius: 150,
                  percent: calculPourcentageTotal(),
                  lineWidth: 24,
                  animation: true,
                  progressColor: Colors.blue,
                  circularStrokeCap: CircularStrokeCap.butt,
                  center: Text(
                    (calculPourcentageTotal() * 100).round().toString() + '%',
                    style: TextStyle(fontSize: 24),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  String calculPourcentage(String rep, String total) {
    if (total == '0'){
      return 'null';
    }
    return (double.parse(rep) / double.parse(total) * 100).round().toString() + '%';
  }

  double calculPourcentageTotal() {
    if ((double.parse(prog.environnement) +
        double.parse(prog.ressource) +
        double.parse(prog.individu) +
        double.parse(prog.tache) +
        double.parse(prog.equipement) +
        double.parse(prog.metier)) == 0){
      return 0;
    }
    return ((double.parse(prog.environnement_rep) +
            double.parse(prog.ressource_rep) +
            double.parse(prog.individu_rep) +
            double.parse(prog.tache_rep) +
            double.parse(prog.equipement_rep) +
            double.parse(prog.metier_rep)) /
            (double.parse(prog.environnement) +
            double.parse(prog.ressource) +
            double.parse(prog.individu) +
            double.parse(prog.tache) +
            double.parse(prog.equipement) +
            double.parse(prog.metier)));
  }

  Widget colonnePourcentage(String rep, String total) {
    if (total == '0'){
      return Text('');
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child:
          Text(calculPourcentage(rep, total), style: TextStyle(fontSize: 26)),
    );
  }

  Widget colonneType(String type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Text(type, style: TextStyle(fontSize: 36)),
    );
  }

  Widget colonneBarre(String rep, String total) {
    if (total == '0'){
      return Padding(
        padding: const EdgeInsets.all(13.5),
        child: Text('Pas de question', style: TextStyle(fontSize: 20)),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: LinearPercentIndicator(
          percent: (double.parse(rep) / double.parse(total)),
          lineHeight: 20,
          animation: true,
          progressColor: Colors.blue,
          linearStrokeCap: LinearStrokeCap.butt,
          width: 275),
    );
  }
}
