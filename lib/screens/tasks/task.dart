import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosto/widgets/card.dart';
import 'package:prosto/widgets/offer_modal.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [
    Marker(
      markerId: MarkerId('marker'),
      position: LatLng(41.00000, 69.454533),
      draggable: true,
    ),
  ];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.32491477131361, 69.2427421733737),
    zoom: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Задание №000001'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ProstoCard(),
                Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Тип оплаты:"),
                            Text("Наличные"),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Заказ создан:"),
                            Text("01.01.2020 12:00"),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Предложений:"),
                            Text("90"),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person_outline,
                              size: 16,
                              color: Color(0xFF68BB49),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "Sasha Raimov Doniyorovich",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              size: 16,
                              color: Color(0xFF68BB49),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "+998 90 329 79 89",
                              style: TextStyle(
                                color: Color(0xFF68BB49),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Детали:"),
                        Container(
                          height: 28,
                          child: Text(
                            'asdasdfasdf sdaf sdalg sdfgsd gsdg sdfg  sdfg re wera ufeuifsdkfigsdkgjf sdhfkghkg sdg h fgsdjk fggasdhf gasdjk kfg gdfgldfsgh sdlkgh sdgh sfh sdlfhsdjafh sdhasfh fk',
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                'Показать',
                                style: TextStyle(
                                  color: Color(0xFF68BB49),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  child: Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onTap: (position) {
                          setState(() {
                            _markers = <Marker>[
                              Marker(
                                markerId: MarkerId('marker'),
                                position: LatLng(
                                    position.latitude, position.longitude),
                                draggable: true,
                              ),
                            ];
                          });
                          print(position.latitude);
                          print(position.longitude);
                        },
                        markers: _markers.length > 0 ? _markers.toSet() : null,
                        onCameraMove: (cameraPosition) {},
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ProstoNewOfferModal(),
                      );
                    },
                    child: Text(
                      'Подать предложение',
                      style: TextStyle(color: Colors.white),
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
