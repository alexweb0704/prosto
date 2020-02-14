import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalWidget extends StatefulWidget {
  final Future request;
  ModalWidget({
    this.request,
  });
  @override
  _ModalWidgetState createState() => _ModalWidgetState();
}

class _ModalWidgetState extends State<ModalWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 4 * 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Создание задания',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFF4C00),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xFFFFFFFF),
                child: FutureBuilder(
                  future: widget.request,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: <Widget>[
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Ваше задание создано.'),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Номер задания: №1'),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Дата создания: 01.02.2020'),
                            ),
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    color: Color(0xFFFF4C00),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ОК',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
