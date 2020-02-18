import 'package:flutter/material.dart';
import 'package:prosto/helpers/locale_storage_helper.dart';
import 'package:prosto/helpers/users.dart';
import 'package:prosto/models/user.dart';
import 'package:prosto/screens/profile/profile_edit_screen.dart';
import 'package:prosto/widgets/drawer.dart';
import 'package:prosto/widgets/profile_services.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Gender gender;
  List<Gender> items = [
    Gender(code: 'male', name: 'Мужской'),
    Gender(code: 'female', name: 'Женский'),
  ];
  Future<User> currentUser = getLocalCurrentUser();
  void _update() async {
    final result = await Navigator.push(
      context,
      await currentUser.then((user) {
        return MaterialPageRoute(
          builder: (context) => ProfileEditScreen(user: user),
        );
      }),
    );

    if (result == null) {
      return;
    }

    if (result.containsKey('user')) {
      currentUser = getLocalCurrentUser();
    }

    if (result.containsKey('snackBarContent')) {
      final ScaffoldState scaffold = widget.scaffoldKey.currentState;
      scaffold.showSnackBar(
        SnackBar(
          content: result['snackBarContent'],
          backgroundColor: result.containsKey('snackBarColor') ? result['snackBarColor'] : null,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      drawer: ProstoDrawer(),
      appBar: AppBar(
        title: Text('Личный кабинет'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: currentUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var user = snapshot.data;
                  print(user.avatarUrl);
                  return Container(
                    height: 200,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/icons/user.png',
                          ),
                        ),
                        user.avatarUrl != null
                            ? Positioned(
                                top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(user.avatarUrl),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Positioned(
                          top: 20.0,
                          right: 20.0,
                          child: FloatingActionButton(
                            onPressed: _update,
                            heroTag: 'save-float-btn',
                            mini: true,
                            backgroundColor: Color(0xFF3F4089),
                            child: Icon(Icons.mode_edit),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: FutureBuilder(
                  future: currentUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var user = snapshot.data;
                      return Text(
                        user.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF68BB49),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: FutureBuilder(
                          future: currentUser,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var user = snapshot.data;
                              return Text(
                                '${user.balance == null ? 0 : user.balance} \$',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFF3F4089),
                                ),
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          child: Text(
                            'Пополнить счет',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF68BB49),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        splashColor: Color(0x6668BB49),
                        highlightColor: Color(0x5568BB49),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
              child: Text(
                'Пол',
                style: TextStyle(fontSize: 16, color: Color(0xAA000000)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder(
                future: currentUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var user = snapshot.data;
                    return Text(
                      user.gender == 'male'
                          ? "Мужской"
                          : user.gender == 'female' ? "Женский" : "Не выбран",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 5),
              child: Text(
                'Серия и номер паспорта',
                style: TextStyle(fontSize: 16, color: Color(0xAA000000)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder(
                  future: currentUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var user = snapshot.data;
                      return Text(
                        user.passport,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 5),
              child: Text(
                'Номер телефона',
                style: TextStyle(fontSize: 16, color: Color(0xAA000000)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder(
                future: currentUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var user = snapshot.data;
                    return Text(
                      user.username,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Сфера деятельности',
                style: TextStyle(fontSize: 16, color: Color(0xAA000000)),
              ),
            ),
            FutureBuilder(
              future: currentUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var user = snapshot.data;
                  return ProfileServices(user.services);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
