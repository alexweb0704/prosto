import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../create/step4.dart';
import 'package:location/location.dart';

class CreateTaskScreen3Map extends StatefulWidget {
  final int serviceId;
  final String title;
  final String description;
  CreateTaskScreen3Map({
    this.serviceId,
    this.title,
    this.description,
  });
  @override
  _CreateTaskScreen3MapState createState() => _CreateTaskScreen3MapState();
}

class _CreateTaskScreen3MapState extends State<CreateTaskScreen3Map> {
  Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _addressController = TextEditingController();
  bool isRemote = false;
  var currentLocation;
  var location = new Location();
  double coorLat;
  double coorLong;
  GoogleMap _map;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.3191816, 69.2965543),
    zoom: 14.4746,
  );

  void _nextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen4(
          serviceId: widget.serviceId,
          title: widget.title,
          description: widget.description,
          isRemote: isRemote,
          address: _addressController.text,
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
        _map.markers.add(Marker(
          position: LatLng(
            coorLat,
            coorLong,
          ),
          draggable: true,
          markerId: MarkerId('suka'),
        ));
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xFFFF4C00),
        ),
        centerTitle: true,
        title: Text(
          'Местоположение',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: _map = GoogleMap(
                  mapToolbarEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF4C00),
        onPressed: _findLocation,
        child: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }
}
