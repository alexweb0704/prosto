import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prosto/screens/tasks/create/step3map.dart';
import '../create/step4.dart';
//import 'package:yandex_mapkit/yandex_mapkit.dart';

class CreateTaskScreen3 extends StatefulWidget {
  final int serviceId;
  final String title;
  final String description;
  CreateTaskScreen3({
    this.serviceId,
    this.title,
    this.description,
  });
  @override
  _CreateTaskScreen3State createState() => _CreateTaskScreen3State();
}

class _CreateTaskScreen3State extends State<CreateTaskScreen3> {
  // YandexMapController controller;
  Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _addressController = TextEditingController();
  bool isRemote = false;
  bool _isMapped = false;
  bool _markerSetted = false;
  double coorLat;
  double coorLong;
  var currentLocation;
  var location = new Location();
  List<Marker> _markers = List();
  //static const Point _point = Point(latitude: 59.945933, longitude: 30.320045);
  // final Placemark _placemark = Placemark(
  //   point: _point,
  //   isDraggable: true,
  //   iconName: 'ac_unit',

  // );
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.32491477131361, 69.2427421733737),
    zoom: 10,
  );

  void _nextScreen() {
    print(widget.serviceId);
    print(widget.title);
    print(widget.description);
    print(isRemote);
    print(_addressController.text);
    print(coorLat);
    print(coorLong);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen4(
          serviceId: widget.serviceId,
          title: widget.title,
          description: widget.description,
          isRemote: isRemote,
          address: _addressController.text,
          coorLat: coorLat,
          coorLong: coorLong,
        ),
      ),
    );
  }

  _findLocation() async {
    try {
      currentLocation = await location.getLocation();
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      coorLat = currentLocation.latitude;
      coorLong = currentLocation.longitude;
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(coorLat, coorLong), zoom: 14.4),
        ),
      );
      setState(() {
        _markers = <Marker>[
          Marker(
            markerId: MarkerId('marker'),
            position: LatLng(coorLat, coorLong),
            draggable: true,
          ),
        ];
        _markerSetted = true;
      });
    } catch (e) {
      print(e);
      currentLocation = null;
    }
  }

  _selectLocation() {
    setState(() {
      _isMapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isMapped == false
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Color(0xFF68BB49),
              ),
              centerTitle: true,
              title: Text(
                'Местоположение',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            )
          : null,
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(children: <Widget>[
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          right: 16.0,
                          bottom: 0,
                          left: 16.0,
                        ),
                        child: Text(
                          'Место проведения работы',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Color(0xFF00AE68),
                        title: Text(
                          'Территория заказчика',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF68BB49),
                          ),
                        ),
                        value: false,
                        groupValue: isRemote,
                        onChanged: (bool value) {
                          print(value);
                          setState(() {
                            isRemote = value;
                          });
                        },
                      ),
                      RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Color(0xFF00AE68),
                        title: Text(
                          'Удаленно',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF68BB49),
                          ),
                        ),
                        value: true,
                        groupValue: isRemote,
                        onChanged: (bool value) {
                          setState(() {
                            isRemote = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Адрес',
                            hintText: 'Укажите адрес',
                            labelStyle: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF68BB49),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top: _isMapped == true ? 0 : 220,
                  bottom: 0,
                  left: 0,
                  right: 0,
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
                            position:
                                LatLng(position.latitude, position.longitude),
                            draggable: true,
                          ),
                        ];
                        _markerSetted = true;
                      });
                      print(position.latitude);
                      print(position.longitude);
                    },
                    markers: _markers.length > 0 ? _markers.toSet() : null,
                    onCameraMove: (cameraPosition) {
                      setState(() {
                        _isMapped = true;
                      });
                    },
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  bottom: _isMapped == true && _markerSetted == false ? 10 : 60,
                  right: 10,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Color(0xFF68BB49),
                    onPressed: _findLocation,
                    child: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top: _isMapped == true ? 0 : -80,
                  height: 80,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 14),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF68BB49), Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isMapped = false;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFF68BB49),
                          ),
                        ),
                        Text(
                          'Карта',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF68BB49),
                          ),
                        ),
                        Container(
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  bottom: _isMapped == true ? -100 : 0,
                  child: Container(
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
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  bottom: _isMapped == true && _markerSetted == true ? 0 : -100,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: FlatButton(
                      color: Color(0xFF68BB49),
                      textColor: Colors.white,
                      onPressed: _selectLocation,
                      child: Text(
                        'Выбрать',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
