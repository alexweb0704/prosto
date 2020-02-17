import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prosto/helpers/payment_types.dart';
import 'package:prosto/helpers/services.dart';
import 'package:prosto/helpers/users.dart';
import 'package:prosto/models/user.dart';
import 'package:prosto/screens/home_screen.dart';
import 'package:prosto/screens/login_screen.dart';
import 'package:prosto/screens/profile/profile_edit_screen.dart';


class LoadingScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () async {
      User currentUser;
        getPaymentTypes({});
      try {
        getServices({});
        currentUser = await getCurrentUser({});
        if (currentUser == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
          return null;
        }
        if (currentUser.name == null || currentUser.name == '') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileEditScreen(),
            ),
          );
          return;
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } catch (e) {
        final ScaffoldState scaffold = widget.scaffoldKey.currentState;
        scaffold.showSnackBar(
          SnackBar(
            content: Text(
              'Что то с интернетом. Проверьте подключение к интернету и перезайдите в приложение',
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/icons/logo.png',
                height: 33,
              ),
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
