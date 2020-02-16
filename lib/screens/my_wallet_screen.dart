import 'package:flutter/material.dart';
import 'package:prosto/widgets/drawer.dart';

class MyWalletScreen extends StatefulWidget {
  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  int _selected = 1;
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ChoiceChip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                    ),
                    label: Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      child: Center(
                        child: Text(
                          'Списания',
                          style: TextStyle(
                            fontSize: 18,
                            color: _selected == 0 ? Colors.white : null,
                          ),
                        ),
                      ),
                    ),
                    elevation: 4,
                    backgroundColor: Colors.white,
                    selectedColor: Color(0xFF68BB49),
                    selected: _selected == 0,
                    onSelected: (value) {
                      setState(() {
                        _selected = 0;
                      });
                    },
                  ),
                  ChoiceChip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(10),
                      ),
                    ),
                    label: Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      child: Center(
                        child: Text(
                          'Пополнение',
                          style: TextStyle(
                            fontSize: 18,
                            color: _selected == 1 ? Colors.white : null,
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 4,
                    selectedColor: Color(0xFF68BB49),
                    selected: _selected == 1,
                    onSelected: (value) {
                      setState(() {
                        _selected = 1;
                      });
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
