import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../create/step4.dart';

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

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
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
                child: GoogleMap(
                  mapToolbarEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
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
