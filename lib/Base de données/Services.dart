import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Utilisateur.dart';
import 'Progression.dart';

class Services {
  static var ROOT = Uri.parse("http://10.0.2.2:80/EmployeesDB/employee_actions.php");
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _GET_ALL_PROG_ACTION = 'GET_ALL_PROG';
  static const _ADD_EMP_ACTION = 'ADD_USER';
  static const _UPDATE_EMP_ACTION = 'UPDATE_USER';
  static const _DELETE_EMP_ACTION = 'DELETE_USER';
  static const _ADD_QUESTION = 'ADD_QUESTION';
  
  static Future<List<Utilisateur>> getUtilisateursListe() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<Utilisateur> list = parseResponse(response.body);
        return list;
      } else {
      }
    } catch (e) {
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
        Progression progression = list.firstWhere((element) => element.id == id, orElse: () {return null;});
        return progression;
      } else {
      }
    } catch (e) {
      return null;
    }
    return null;
  }
  static Future<Utilisateur> getUtilisateur(String id) async {
    List<Utilisateur> list = await getUtilisateursListe();
    Utilisateur user = list.firstWhere((element) => element.id == id, orElse: () {return null;});
    return user;
  }

  static List<Utilisateur> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Utilisateur>((json) => Utilisateur.fromJson(json)).toList();
  }
  static List<Progression> parseResponseProg(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Progression>((json) => Progression.fromJson(json)).toList();
  }

  // Method to add Utilisateur to the database...
  static Future<String> addUtilisateur(String id, String nom, String prenom,String password, String type, String id_prof, String nom_stage,) async {
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
      print(id + '-' + prenom + '-' + nom + '-' + type);
      final response = await http.post(ROOT, body: map);
      print('addUtilisateur Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        print(response.statusCode);
        return "error";
      }
    } catch (e) {
      print(e);
      return "error + xddd";
    }
  }
  static Future<String> addQuestion(String id_prof, String id_eleve,String question, String type) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_QUESTION;
      map['id_prof'] = id_prof;
      map['id_eleve'] = id_eleve;
      map['question'] = question;
      map['type'] = type;
      final response = await http.post(ROOT, body: map);
      print('addUtilisateur Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        print(response.statusCode);
        return "error";
      }
    } catch (e) {
      print(e);
      return "error + xddd";
    }
  }

  // Method to update an Utilisateur in Database...
  static Future<String> updateUtilisateur(
      String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('updateUtilisateur Response: ${response.body}');
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
}
