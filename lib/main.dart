import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'screens/lang_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Color(0XFFFF4C00),
        buttonColor: Color(0XFFFF4C00),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0XFFFF4C00),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Color(0xFF00AE68),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color(0x25000000),
          ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/lang': (BuildContext context) => LangScreen(),
        '/': (BuildContext context) => LoadingScreen(),
      },
    );
  }
}
