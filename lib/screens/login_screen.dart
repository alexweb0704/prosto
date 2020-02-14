import 'package:flutter/material.dart';
import 'package:prosto/helpers/http_helper.dart';
import '../screens/home_screen.dart';
import 'package:localstorage/localstorage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final LocalStorage storage = new LocalStorage('prosto_app');

  bool _loading = false;
  bool _isRequest = false;
  bool _isUsername = false;
  //bool _loading = false;
  String password;
  void _logining() async {
    setState(() {
      _loading = true;
    });
    print(_usernameController.text);
    Map<String, String> operation = await HttpHelper.logining(
      username: '+998' + _usernameController.text,
      password: _passwordController.text,
    );
    setState(() {
      _loading = false;
    });
    if (operation.containsKey('password')) {
      setState(() {
        _isUsername = true;
        _passwordController.text = operation['password'];
      });
      print(operation['password']);
      return;
    }
    if (operation.containsKey('error')) {
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Image.asset(
                'assets/icons/user-check.png',
                width: 200,
                height: 200,
              ),
              Image.asset(
                'assets/icons/logo.png',
                height: 33,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Войди',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              AnimatedContainer(
                height: MediaQuery.of(context).viewInsets.bottom == 0 ? 90 : 0,
                curve: Curves.easeInCubic,
                duration: Duration(milliseconds: 200),
              ),
              if (_isUsername == false)
                Container(
                  child: TextField(
                    controller: _usernameController,
                    maxLength: 9,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        value.length == 9
                            ? _isRequest = true
                            : _isRequest = false;
                      });
                      print(value.length);
                    },
                    decoration: InputDecoration(
                      hintText: '91 234 56 78',
                      prefixText: '+998 ',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      labelText: 'Телефон',
                    ),
                  ),
                )
              else
                Container(
                  child: TextField(
                    controller: _passwordController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        value.length == 6
                            ? _isRequest = true
                            : _isRequest = false;
                      });
                      print(value.length);
                    },
                    decoration: InputDecoration(
                      hintText: '123456',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      labelText: 'Код',
                    ),
                  ),
                ),
              SizedBox(
                height: 30,
              ),
              if (_isUsername == false)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: FlatButton(
                    color: Color(0xFF68BB49),
                    textColor: Colors.white,
                    onPressed: _isRequest && _loading == false ? _logining : null,
                    child: Text(
                      'Получить код',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: FlatButton(
                    color: Color(0xFF68BB49),
                    textColor: Colors.white,
                    onPressed: _isRequest && _loading == false ? _logining : null,
                    child: Text(
                      'Войти',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height:
                    MediaQuery.of(context).viewInsets.bottom == 0 ? 100 : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
