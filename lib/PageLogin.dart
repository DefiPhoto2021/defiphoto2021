import 'MenuPrincipal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'Services.dart';
import 'Utilisateur.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLogin createState() => _PageLogin();
}

class _PageLogin extends State<PageLogin> {
  final passCtrl = TextEditingController();
  final userCtrl = TextEditingController();
  Utilisateur utilisateur;

  bool obstructText = true;
  bool loginFailed = false;

  void onLogin(String user, String pass) async {
    Utilisateur utilisateur = await Services.getUtilisateur(user);
    if (utilisateur != null) {
      if (utilisateur.password == pass) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', utilisateur.id);
        if (utilisateur.type == 'É') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MenuPrincipal(utilisateur)));
        } else if (utilisateur.type == 'P') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MenuPrincipal(utilisateur)));
        } else if (utilisateur.type == 'A') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MenuPrincipal(utilisateur)));
        }
        loginFailed = true;
      } else {
        setState(() {
          loginFailed = true;
        });
      }
    } else {
      setState(() {
        loginFailed = true;
      });
    }
  }

  void _togglePasswordView() {
    setState(() {
      obstructText = !obstructText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              TextField(
                controller: userCtrl,
                decoration: InputDecoration(
                  hintText: "ID d'utilisateur",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passCtrl,
                obscureText: obstructText,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    errorText: loginFailed ? "Mot de passe incorrecte" : null,
                    hintText: "Mot de passe",
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(obstructText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 400,
                height: 45,
                child: ElevatedButton(
                    onPressed: () => onLogin(userCtrl.text, passCtrl.text),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
