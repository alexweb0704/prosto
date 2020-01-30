import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/lang_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LangScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'PRO',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 50,
                  ),
                ),
                Text(
                  'sto',
                  style: TextStyle(
                    color: Color(0xFFFF4C00),
                    fontSize: 50,
                  ),
                ),
              ],
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
