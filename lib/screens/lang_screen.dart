import 'package:flutter/material.dart';
import 'introduction_screen.dart';
import 'package:localstorage/localstorage.dart';
class LangScreen extends StatefulWidget {
  @override
  _LangScreenState createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  final LocalStorage storage = new LocalStorage('prosto_app');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'tag1',
                child: Row(
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
              ),
              SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/icons/save.png',
                width: 140,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Выберите язык',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntroductionScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Русский',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text(
                    'O\'zbekcha',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
