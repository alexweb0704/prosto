import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prosto/models/task.dart';

class ProstoCard extends StatefulWidget {
  final Task task;
  final bool showUser;
  final Function tapHandler;
  ProstoCard({this.task, this.showUser, this.tapHandler});
  @override
  _ProstoCardState createState() => _ProstoCardState();
}

class _ProstoCardState extends State<ProstoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: InkWell(
        onTap: widget.tapHandler,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: widget.task.status.code == 'new'
                    ? Colors.white
                    : widget.task.status.code == 'executor_selected' ||
                            widget.task.status.code == 'is_performed'
                        ? Color(0xFF3F4089)
                        : Color(0xFF68BB49),
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
                        widget.task.isRemote
                            ? 'Удаленнае задание'
                            : widget.task.address,
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
                      Text(
                        widget.task.startedAt != null
                            ? DateFormat('dd.mm.yyyy hh:mm')
                                .format(widget.task.startedAt)
                                .toString()
                            : 'Не определено',
                      ),
                      Expanded(
                        child: Text(""),
                      ),
                      Text(widget.task.service.name),
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
                      Text(
                        widget.task.finishedAt != null
                            ? DateFormat('dd.mm.yyyy hh:mm')
                                .format(widget.task.finishedAt)
                                .toString()
                            : 'Не определено',
                      ),
                      Expanded(
                        child: Text(""),
                      ),
                      Text(
                        widget.task.price.toString(),
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
                  widget.showUser ? Container(
                    margin: EdgeInsets.only(
                      top: 4.0,
                      bottom: 6.0,
                    ),
                    height: 1,
                    color: Color(0xFF68BB49),
                  ) : Container(),
                  widget.showUser ? Row(
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
                          widget.task.user.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        widget.task.user.username,
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
                  ) : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}