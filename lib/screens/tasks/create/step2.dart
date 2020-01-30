import 'package:flutter/material.dart';
import '../create/step3.dart';

class CreateTaskScreen2 extends StatefulWidget {
  final int serviceId;
  CreateTaskScreen2({this.serviceId});
  @override
  _CreateTaskScreen2State createState() => _CreateTaskScreen2State();
}

class _CreateTaskScreen2State extends State<CreateTaskScreen2> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _nextScreen() {
    print(widget.serviceId.toString());
    print(_titleController.text);
    print(_descriptionController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen3(
          serviceId: widget.serviceId,
          title: _titleController.text,
          description: _descriptionController.text,
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
          color: Color(0xFFFF4C00),
        ),
        centerTitle: true,
        title: Text(
          'Создание задачи',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  hintText: 'Добавьте описание задачи',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFF4C00),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: _descriptionController,
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Детали',
                  hintText: 'Добавьте детали задачи',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFF4C00),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: FlatButton(
                color: Color(0xFFFF4C00),
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
