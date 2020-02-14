import 'package:flutter/material.dart';
import 'package:prosto/models/task.dart';
import 'package:prosto/screens/tasks/task.dart';

class ProstoCard extends StatefulWidget {
  final Task task;
  final bool showUser;
  ProstoCard({this.task, this.showUser});
  @override
  _ProstoCardState createState() => _ProstoCardState();
}

class _ProstoCardState extends State<ProstoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskScreen(),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Color(0xFF68BB49),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.task.title != null ? widget.task.title : '',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF68BB49),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color(0xFF3F4089),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Ташкент, улица мразь",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Color(0xFF3F4089),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("01.01.2020 15:00"),
                      Expanded(
                        child: Text(""),
                      ),
                      Text("Категория"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.library_books,
                        size: 16,
                        color: Color(0xFF3F4089),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Color(0xFF68BB49),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("01.01.2020 15:00"),
                      Expanded(
                        child: Text(""),
                      ),
                      Text(
                        "50 000.00",
                        style: TextStyle(
                          color: Color(0xFF68BB49),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.attach_money,
                        size: 16,
                        color: Color(0xFF68BB49),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 4.0,
                      bottom: 6.0,
                    ),
                    height: 1,
                    color: Color(0xFF68BB49),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Color(0xFF68BB49),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Sasha Raimov Doniyorovich",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "+998 90 329 79 89",
                        style: TextStyle(
                          color: Color(0xFF68BB49),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: Color(0xFF68BB49),
                      ),
                    ],
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