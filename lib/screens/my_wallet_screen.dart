import 'package:flutter/material.dart';
import 'package:prosto/widgets/drawer.dart';

class MyWalletScreen extends StatefulWidget {
  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ProstoDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Мой кошелек'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 10 / 100,
              ),
              child: Card(
                elevation: 4.0,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.attach_money,
                      size: 50,
                      color: Color(0xFF3F4089),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '175 900.00 сум',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF68BB49),
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            DefaultTabController(
              length: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    TabBar(
                      onTap: (value) {
                        setState(() {
                          _selected = value;
                        });
                      },
                      indicator: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10),
                        ),
                      ),
                      indicatorPadding: EdgeInsets.all(0),
                      labelPadding: EdgeInsets.all(0),
                      tabs: <Widget>[
                        Tab(

                          text: 'Списания',
                        ),
                        Tab(
                          text: 'Пополнения',
                        ),
                      ],
                    ),
                    TabBarView(
                      children: <Widget>[
                        Text('suka'),
                        Text('pider'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
