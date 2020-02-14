import 'package:flutter/material.dart';
import 'package:prosto/helpers/http_helper.dart';
import 'package:prosto/models/payment_type.dart';

class ProstoNewOfferModal extends StatefulWidget {
  @override
  _ProstoNewOfferModalState createState() => _ProstoNewOfferModalState();
}

class _ProstoNewOfferModalState extends State<ProstoNewOfferModal> {
  Future<List<PaymentType>> _futurePaymentTypes = HttpHelper.getPaymentTypes();
  PaymentType _selected;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(5)),
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(5),
                ),
                color: Color(0xFF68BB49),
              ),
              child: Center(
                child: Text(
                  'Подать предложение',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      labelText: 'Описание',
                      hintText: 'Добавте описание предложения',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      labelText: 'Сумма',
                      hintText: 'Введите вашу сумму',
                      suffixText: 'Сумм',
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
                            horizontal: 10.0,
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
                              hint: Text('Выберите форму оплаты', overflow: TextOverflow.ellipsis,),
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  TextField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      labelText: 'Комментарий',
                      hintText: 'Введите ваш комментарий',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                onPressed: () {},
                child: Text('Подать предложение'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.vertical(
                    bottom: Radius.circular(5),
                  ),
                ),
                color: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                onPressed: () {},
                child: Text(
                  'Отмена',
                  style: TextStyle(
                    color: Colors.white,
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
