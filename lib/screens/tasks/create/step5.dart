import 'package:flutter/material.dart';
import '../../../helpers/http_helper.dart';
import '../../../models/payment_type.dart';
import '../../../widgets/modal.dart';

class CreateTaskScreen5 extends StatefulWidget {
  final int serviceId;
  final String title;
  final String description;
  final bool isRemote;
  final String address;
  final DateTime startedAt;
  final DateTime finishedAt;
  final double coorLat;
  final double coorLong;
  CreateTaskScreen5({
    this.serviceId,
    this.title,
    this.description,
    this.isRemote,
    this.address,
    this.startedAt,
    this.finishedAt,
    this.coorLat,
    this.coorLong,
  });
  @override
  _CreateTaskScreen5State createState() => _CreateTaskScreen5State();
}

class _CreateTaskScreen5State extends State<CreateTaskScreen5> {
  Future<List<PaymentType>> _futurePaymentTypes = HttpHelper.getPaymentTypes();
  final TextEditingController _priceController = TextEditingController();
  PaymentType _selected;
  int _price = 0;
  Map<String, dynamic> _task;
  _createTask() {
    if (_selected != null) {
      print(widget.serviceId);
      print(widget.title);
      print(widget.description);
      print(widget.isRemote);
      print(widget.address);
      print(widget.startedAt);
      print(widget.finishedAt);
      print(_price);
      print(_selected.id);
      _task = {
        "title": widget.title,
        "description": widget.description,
        "service_id": widget.serviceId,
        "is_remote": widget.isRemote,
        "address": widget.address,
        "started_at": widget.startedAt,
        "finished_at": widget.finishedAt,
        "price": _price,
        "payment_type_id": _selected.id,
      };
      showDialog(
        context: context,
        builder: (BuildContext context) => ModalWidget(
          request: HttpHelper.createTask(_task, context),
        ),
      );
    }
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
          'Оплата',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: _priceController,
                onChanged: (val) {
                  val = val.replaceAll(' ', '');
                  setState(() {
                    _price = int.parse(val);
                  });
                  //print(_price);
                },
                keyboardType: TextInputType.number,
                keyboardAppearance: Brightness.light,
                decoration: InputDecoration(
                  suffixText: 'Сум',
                  hintText: '100 000',
                  labelText: 'Сумма',
                  labelStyle: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF68BB49),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _futurePaymentTypes,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<DropdownMenuItem<PaymentType>> items = List();
                  var paymentTypes = snapshot.data;
                  for (final paymentType in paymentTypes) {
                    items.add(DropdownMenuItem(
                      value: paymentType,
                      child: Text(paymentType.name),
                    ));
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0x25000000),
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _selected,
                        items: items,
                        onChanged: (value) {
                          setState(() {
                            _selected = value;
                          });
                        },
                        hint: Text('Выберите форму оплаты'),
                        style: TextStyle(
                          color: Color(0xFF68BB49),
                          fontSize: 18.0,
                        ),
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: Color(0xFF68BB49),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
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
                onPressed: _price != 0 && _price >= 1000 && _selected != null
                    ? _createTask
                    : null,
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
