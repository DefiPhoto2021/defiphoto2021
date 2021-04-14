import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PageListeUtilisateur.dart';
import 'PageLogin.dart';
import 'PageQuestionProf.dart';
import 'Services.dart';
import 'PageProfil.dart';
import 'PageProgression.dart';
import 'PageCreationProfil.dart';
import 'PageListeEleves.dart';

Future<void> main() async {
  ThemeData themeData(){
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blueGrey,
      fontFamily: 'Georgia',
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('id');
  if (id != null){
    Services.getUtilisateur(id).then((value){
      if (value.type == 'É'){
        runApp(MaterialApp(home: PageProgression(value), theme: themeData()));
      } else if (value.type == 'P'){
        runApp(MaterialApp(home: PageQuestionProf(value),theme: themeData()));
      }else if (value.type == 'A'){
        runApp(MaterialApp(home: PageListeUtilisateur(value),theme: themeData()));
      }
    });
  }
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/creationProfile': (context) => new PageCreationProfile(null),
            '/login': (context) => new PageLogin(),
            '/listeEleves': (context) => new PageListeEleves(null),
            '/progression': (context) => new PageProgression(null),
            '/profil': (context) => new PageProfil(null),
            '/aide': (context) => new PageProgression(null),
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blueGrey,
            fontFamily: 'Georgia',
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          ),
          initialRoute: '/login',
        ));
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

