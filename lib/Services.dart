import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Reponse.dart';
import 'Utilisateur.dart';
import 'Progression.dart';
import 'Question.dart';

class Services {
  static var ROOT = Uri.parse("http://10.0.2.2:80/crud_api.php"); //10.0.2.2
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _GET_ALL_PROG_ACTION = 'GET_ALL_PROG';
  static const _GET_ALL_QUESTION_ACTION = 'GET_ALL_QUESTION';
  static const _GET_ALL_REPONSE_ACTION = 'GET_ALL_REPONSE';
  static const _ADD_EMP_ACTION = 'ADD_USER';
  static const _DELETE_EMP_ACTION = 'DELETE_USER';
  static const _ADD_QUESTION = 'ADD_QUESTION';
  static const _ADD_REPONSE = 'ADD_REPONSE';
  static const _UPDATE_QUESTION = 'UPDATE_QUESTION';
  static const _UPDATE_QUESTION_TEST = 'UPDATE_QUESTION_TEXT';
  static const _DELETE_QUESTION = 'DELETE_QUESTION';

  static Future<List<Utilisateur>> getUtilisateursListe() async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<Utilisateur> list = parseResponse(response.body);
        return list;
      } else {}
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<Progression> getProgression(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_PROG_ACTION;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<Progression> list = parseResponseProg(response.body);
        Progression progression =
            list.firstWhere((element) => element.id == id, orElse: () {
          return null;
        });
        return progression;
      } else {}
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<List<Question>> getQuestionListe() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_QUESTION_ACTION;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<Question> list = parseReponseQuestion(response.body);
        return list;
      } else {}
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<List<Reponse>> getReponseListe() async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_REPONSE_ACTION;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<Reponse> list = parseReponseReponse(response.body);
        return list;
      } else {}
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<Question> getQuestion(String id) async {
    List<Question> list = await getQuestionListe();
    Question question =
        list.firstWhere((element) => element.id == id, orElse: () {
      return null;
    });
    return question;
  }

  static Future<Reponse> getReponse(String id) async {
    List<Reponse> list = await getReponseListe();
    Reponse reponse =
        list.firstWhere((element) => element.id == id, orElse: () {
      return null;
    });
    return reponse;
  }

  static Future<Utilisateur> getUtilisateur(String id) async {
    List<Utilisateur> list = await getUtilisateursListe();
    Utilisateur user;
    if (list != null) {
      user = list.firstWhere((element) => element.id == id, orElse: () {
        return null;
      });
    }
    return user;
  }

  static List<Utilisateur> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Utilisateur>((json) => Utilisateur.fromJson(json))
        .toList();
  }

  static List<Progression> parseResponseProg(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Progression>((json) => Progression.fromJson(json))
        .toList();
  }

  static List<Question> parseReponseQuestion(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Question>((json) => Question.fromJson(json)).toList();
  }

  static List<Reponse> parseReponseReponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Reponse>((json) => Reponse.fromJson(json)).toList();
  }

  // Method to add Utilisateur to the database...
  static Future<String> addUtilisateur(
    String id,
    String nom,
    String prenom,
    String password,
    String type,
    String id_prof,
    String nom_stage,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['id'] = id;
      map['nom'] = nom;
      map['prenom'] = prenom;
      map['password'] = password;
      map['type'] = type;
      map['id_prof'] = id_prof;
      map['nom_stage'] = nom_stage;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }

  static Future<String> addQuestion(String id_question, String id_prof,
      String id_eleve, String question, String type) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_QUESTION;
      map['id_question'] = id_question;
      map['id_prof'] = id_prof;
      map['id_eleve'] = id_eleve;
      map['question'] = question;
      map['type'] = type;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }

  static Future<String> addReponse(String id, String reponse, String image_name,
      String id_eleve, String type) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_REPONSE;
      map['id'] = id;
      map['reponse'] = reponse;
      map['image_name'] = image_name;
      map['id_eleve'] = id_eleve;
      map['type'] = type;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }

  // Method to update an Utilisateur in Database...
  static Future<String> updateQuestionReponse(
      String reponse_id, String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_QUESTION;
      map['reponse_id'] = reponse_id;
      map['id'] = id;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateQuestionText(String question, String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_QUESTION_TEST;
      map['id'] = id;
      map['question'] = question;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an Utilisateur from Database...
  static Future<String> deleteUtilisateur(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['id'] = id;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print(e);
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  static Future<String> deleteQuestion(
      String id, String type, String id_eleve, String reponse_id, String rep) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_QUESTION;
      map['id'] = id;
      map['type'] = type;
      map['id_eleve'] = id_eleve;
      map['reponse_id'] = reponse_id;
      map['rep'] = rep;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print(e);
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
