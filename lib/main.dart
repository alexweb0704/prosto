import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:prosto/screens/login_screen.dart';
import 'package:prosto/screens/no_connection.dart';
import 'screens/loading_screen.dart';
import 'screens/lang_screen.dart';

final String domain = 'http://prosto.iglight.uz/mob-api';
final LocalStorage storage = new LocalStorage('prosto_app');

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prosto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF68BB49),
        buttonColor: Color(0XFF68BB49),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0XFF68BB49),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xFF3F4089),
          ),
          textTheme: TextTheme(
            title: TextStyle(color: Color(0xFF3F4089), fontSize: 20.0),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF68BB49),
            ),
          ),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.only(bottom: 0),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/lang': (BuildContext context) => LangScreen(),
        '/': (BuildContext context) => LoadingScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/no-connection': (BuildContext context) => NoConnectionScreen(),
      },
    );
  }
}