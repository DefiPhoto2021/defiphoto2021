import 'package:flutter/material.dart';
import 'Services.dart';
import 'Utilisateur.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        accentColor: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final passCtrl = TextEditingController();
  final userCtrl = TextEditingController();
  Utilisateur utilisateur;

  bool obstructText = true;
  bool loginFailed = false;

  void onLogin(String user, String pass) async {
    Utilisateur utilisateur = await Services.getUtilisateur(user);
    if (utilisateur != null) {
      if (utilisateur.pass == pass) {
        print('login successful');
        //Navigator.push(
        //context,
        //MaterialPageRoute(
        //builder: (context) => profil(utilisateur)),
        // );
        loginFailed = false;
      } else {
        print('login failed');
        setState(() {
          loginFailed = true;
        });
      }
    } else {
      print('login failed');
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextField(
              controller: userCtrl,
              decoration: InputDecoration(
                hintText: "Nom d'utilisateur",
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
                    child: Icon(
                        obstructText ? Icons.visibility : Icons.visibility_off),
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
    );
  }
}
