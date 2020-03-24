import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
  double coorLat;
  double coorLong;
  var currentLocation;
  var location = new Location();
  List<Marker> _markers = List();

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
      });
    } catch (e) {
      print(e);
      currentLocation = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Местополежение'),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          mapToolbarEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (position) {
            setState(() {
              _markers = <Marker>[
                Marker(
                  markerId: MarkerId('marker'),
                  position: LatLng(position.latitude, position.longitude),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: _findLocation,
      ),
      bottomSheet: DraggableScrollableSheet(
        expand: false,
        initialChildSize: _markers.length == 0 ? 0.13 : .39,
        minChildSize: .13,
        maxChildSize: .39,
        builder: (context, scrollController) => Container(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      print(isRemote);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _addressController,
                      enabled: !isRemote,
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
                    height: 6,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: FlatButton(
                      color: Color(0xFF68BB49),
                      textColor: Colors.white,
                      onPressed: isRemote ||
                              (_markers.length > 0 &&
                                  _addressController.text.length > 1)
                          ? _nextScreen
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
          ),
        ),
      ),
    );
  }
}
