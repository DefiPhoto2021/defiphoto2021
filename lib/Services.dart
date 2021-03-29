import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Utilisateur.dart';

class Services {
  static var ROOT = Uri.parse("http://10.0.2.2:80/EmployeesDB/employee_actions.php");
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_USER';
  static const _UPDATE_EMP_ACTION = 'UPDATE_USER';
  static const _DELETE_EMP_ACTION = 'DELETE_USER';
  
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
  static Future<Utilisateur> getUtilisateur(String username) async {
    List<Utilisateur> list = await getUtilisateursListe();
    Utilisateur user = list.firstWhere((element) => element.user == username, orElse: () {return null;});
    return user;
  }

  static List<Utilisateur> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Utilisateur>((json) => Utilisateur.fromJson(json)).toList();
  }

  // Method to add Utilisateur to the database...
  static Future<String> addUtilisateur(String username, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['username'] = username;
      map['password'] = password;
      final response = await http.post(ROOT, body: map);
      print('addUtilisateur Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
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
  static Future<String> deleteUtilisateur(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      print('deleteUtilisateur Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
