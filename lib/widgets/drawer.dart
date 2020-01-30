import 'package:flutter/material.dart';

class ProstoDrawer extends StatefulWidget {
  @override
  _ProstoDrawerState createState() => _ProstoDrawerState();
}

class _ProstoDrawerState extends State<ProstoDrawer> {
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
                            Stack(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/user.png',
                                ),
                                Positioned(
                                  top: 38,
                                  right: 38,
                                  bottom: 38,
                                  left: 38,
                                  child: Image.asset(
                                    'assets/icons/save.png',
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Sasha Raimov Doniyor o\'g\'li',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Color(0xFFFF4C00),
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
                                        color: Color(0xFFFF4C00),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  splashColor: Color(0x66FF4C00),
                                  highlightColor: Color(0x55FF4C00),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
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
                    splashColor: Color(0x66FF4C00),
                    highlightColor: Color(0x55FF4C00),
                  ),
                  InkWell(
                    onTap: () {},
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
                    splashColor: Color(0x66FF4C00),
                    highlightColor: Color(0x55FF4C00),
                  ),
                  InkWell(
                    onTap: () {},
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
                    splashColor: Color(0x66FF4C00),
                    highlightColor: Color(0x55FF4C00),
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
                    splashColor: Color(0x66FF4C00),
                    highlightColor: Color(0x55FF4C00),
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
                    splashColor: Color(0x66FF4C00),
                    highlightColor: Color(0x55FF4C00),
                  ),
                  InkWell(
                    onTap: () {},
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
                    splashColor: Color(0x66FF4C00),
                    highlightColor: Color(0x55FF4C00),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Text(
                  'Выход',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ),
              splashColor: Color(0x66FF4C00),
              highlightColor: Color(0x55FF4C00),
            ),
            Container(
              color: Color(0xFFFF4C00),
              padding: EdgeInsets.all(20.0),
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
                  Text(
                    '100 000 000\$',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
