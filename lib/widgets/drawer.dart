import 'package:flutter/material.dart';
import 'package:prosto/helpers/token.dart';
import 'package:prosto/helpers/users.dart';
import 'package:prosto/models/user.dart';
import 'package:prosto/screens/loading_screen.dart';
import 'package:prosto/screens/my_wallet_screen.dart';
import 'package:prosto/screens/profile/profile_screen.dart';
import '../screens/tasks/create/step1.dart';
import '../screens/tasks/find/find_task.dart';

class ProstoDrawer extends StatefulWidget {
  @override
  _ProstoDrawerState createState() => _ProstoDrawerState();
}

class _ProstoDrawerState extends State<ProstoDrawer> {
  Future<User> currentUser = getLocalCurrentUser();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 260,
                    child: DrawerHeader(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            FutureBuilder(
                              future: currentUser,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var user = snapshot.data;
                                  print(user.avatarUrl);
                                  return Stack(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/icons/user.png',
                                        height: 192,
                                      ),
                                      user.avatarUrl != null
                                          ? Positioned(
                                              top: 42,
                                              right: 38,
                                              bottom: 38,
                                              left: 42,
                                              child: CircleAvatar(
                                                radius: 500,
                                                backgroundColor: Colors.white,
                                                backgroundImage: NetworkImage(
                                                    user.avatarUrl),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder(
                              future: currentUser,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var user = snapshot.data;
                                  return Text(
                                    user.name != null ? user.name : '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  );
                                }
                                return Text('     ');
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Color(0xFF68BB49),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
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
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Личный кабинет',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    splashColor: Color(0x6668BB49),
                    highlightColor: Color(0x5568BB49),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTaskScreen1(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Создать задание',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    splashColor: Color(0x6668BB49),
                    highlightColor: Color(0x5568BB49),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FindTaskScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Найти задание',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    splashColor: Color(0x6668BB49),
                    highlightColor: Color(0x5568BB49),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Мои задания',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    splashColor: Color(0x6668BB49),
                    highlightColor: Color(0x5568BB49),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Уведомления',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    splashColor: Color(0x6668BB49),
                    highlightColor: Color(0x5568BB49),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyWalletScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Мой кошелек',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    splashColor: Color(0x6668BB49),
                    highlightColor: Color(0x5568BB49),
                  ),
                  InkWell(
                    onTap: () async {
                      await invalidateToken({});
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Выход',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    splashColor: Color(0x6668BB49),
                    highlightColor: Color(0x5568BB49),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFF68BB49),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Баланс:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  FutureBuilder(
                    future: currentUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var user = snapshot.data;
                        return Text(
                          '${user.balance != null ? user.balance : 0} \$',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
