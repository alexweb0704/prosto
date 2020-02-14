import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prosto/helpers/http_helper.dart';
import 'package:prosto/helpers/locale_storage_helper.dart';
import 'package:prosto/models/user.dart';
import 'package:prosto/screens/home_screen.dart';
import 'package:prosto/screens/login_screen.dart';
import 'package:prosto/screens/profile/profile_edit_screen.dart';
import '../screens/lang_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () async {
      User currentUser;
      try {
        currentUser = await HttpHelper.getUser(context);
      } catch (e) {
        currentUser = await LStorage.getUser();
      }
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
