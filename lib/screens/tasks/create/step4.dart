import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../create/step5.dart';

class CreateTaskScreen4 extends StatefulWidget {
  final int serviceId;
  final String title;
  final String description;
  final bool isRemote;
  final String address;
  final double coorLat;
  final double coorLong;
  CreateTaskScreen4({
    this.serviceId,
    this.title,
    this.description,
    this.isRemote,
    this.address,
    this.coorLat,
    this.coorLong,
  });
  @override
  _CreateTaskScreen4State createState() => _CreateTaskScreen4State();
}

class _CreateTaskScreen4State extends State<CreateTaskScreen4> {
  var startDate = DateTime.now();
  var startTime = TimeOfDay.now();
  var endDate = DateTime.now();
  var endTime = TimeOfDay.now();

  _showDatePicker(current, type) async {
    await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primaryColor: Color(0xFF68BB49),
            accentColor: Color(0xff00ae68),
          ),
          child: child,
        );
      },
    ).then((DateTime dateTime) {
      if (dateTime != null && type == 'start') {
        setState(() {
          startDate = dateTime;
        });
      } else if (dateTime != null && type == 'end') {
        setState(() {
          endDate = dateTime;
        });
      }
    }).catchError(
      (e) {
        return current;
      },
    );
  }

  _showTimePicker(current, type) async {
    await showTimePicker(
      context: context,
      initialTime: current,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primaryColor: Color(0xFF68BB49),
            accentColor: Color(0xff00ae68),
          ),
          child: child,
        );
      },
    ).then((TimeOfDay time) {
      if (time != null && type == 'start') {
        setState(() {
          startTime = time.replacing(hour: time.hour);
        });
      } else if (time != null && type == 'end') {
        setState(() {
          endTime = time;
        });
      }
    });
  }

  _nextScreen() {
    DateTime startedAt = DateTime.parse(startDate.toString().split(' ')[0] +
        ' ${startTime.hour == 0 ? '00' : startTime.hour}:${startTime.minute == 0 ? '00' : startTime.minute < 10 ? 0.toString() + startTime.minute.toString() : startTime.minute}');
    DateTime finishedAt = DateTime.parse(endDate.toString().split(' ')[0] +
        ' ${endTime.hour == 0 ? '00' : endTime.hour}:${endTime.minute == 0 ? '00' : endTime.minute < 10 ? 0.toString() + endTime.minute.toString() : endTime.minute}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen5(
          serviceId: widget.serviceId,
          title: widget.title,
          description: widget.description,
          isRemote: widget.isRemote,
          address: widget.address,
          startedAt: startedAt,
          finishedAt: finishedAt,
          coorLat: widget.coorLat,
          coorLong: widget.coorLong,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xFF68BB49),
        ),
        centerTitle: true,
        title: Text(
          'Время',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: Text('Начало работы'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await _showDatePicker(startDate, 'start');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0x25000000),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        DateFormat('dd.MM.yyyy').format(startDate).toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF68BB49),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _showTimePicker(startTime, 'start');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0x25000000),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        '${startTime.hour == 0 ? '00' : startTime.hour}:${startTime.minute == 0 ? '00' : startTime.minute < 10 ? 0.toString() + startTime.minute.toString() : startTime.minute}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF68BB49),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: Text('Конец работы'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await _showDatePicker(endDate, 'end');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0x25000000),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        DateFormat('dd.MM.yyyy').format(endDate).toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF68BB49),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _showTimePicker(endTime, 'end');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0x25000000),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        '${endTime.hour == 0 ? '00' : endTime.hour}:${endTime.minute == 0 ? '00' : endTime.minute < 10 ? 0.toString() + endTime.minute.toString() : endTime.minute}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF68BB49),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: FlatButton(
                color: Color(0xFF68BB49),
                textColor: Colors.white,
                onPressed: _nextScreen,
                child: Text(
                  'Далее',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
