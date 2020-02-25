import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prosto/helpers/offers.dart';
import 'package:prosto/helpers/payment_types.dart';
import 'package:prosto/models/offer.dart';
import 'package:prosto/models/payment_type.dart';

class ProstoNewOfferModal extends StatefulWidget {
  final int taskId;
  ProstoNewOfferModal(this.taskId);
  @override
  _ProstoNewOfferModalState createState() => _ProstoNewOfferModalState();
}

class _ProstoNewOfferModalState extends State<ProstoNewOfferModal> {
  Future<List<PaymentType>> _futurePaymentTypes = getLocalPaymentTypes();
  PaymentType _paymentType;
  TextEditingController commentController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool _validated = false;
  bool _isLoading = false;
  int price;
  _validator(value) {
    price = int.parse(priceController.text.replaceAll(' ', ''));
    print(price);
    if (price >= 1000 &&
        commentController.text.length > 100 &&
        _paymentType != null) {
      setState(() {
        _validated = true;
      });
      return;
    }
    setState(() {
      _validated = false;
    });
    return;
  }

  _createOffer() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> map = {
      "task_id": widget.taskId,
      "price": price,
      "comment": commentController.text,
      "payment_type_id": _paymentType.id,
    };

    Offer offer = await createOffer(map);
    if (offer != null) {
      Navigator.pop(context, offer);
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

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
                    controller: priceController,
                    onChanged: _validator,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      labelText: 'Сумма',
                      hintText: 'Введите вашу сумму',
                      suffixText: 'Сум',
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                paymentType.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ));
                        }
                        return Container(
                          margin: EdgeInsets.symmetric(
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
                              value: _paymentType,
                              items: items,
                              onChanged: (value) {
                                setState(() {
                                  _paymentType = value;
                                });
                                _validator(value);
                              },
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Выберите форму оплаты',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
                    controller: commentController,
                    maxLines: 6,
                    onChanged: _validator,
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
                onPressed: _validated && !_isLoading ? _createOffer : null,
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
