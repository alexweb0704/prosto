import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosto/screens/tasks/create/step3map.dart';
import '../create/step4.dart';

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
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        color: Color(0xFFFF4C00),
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
                        color: Color(0xFFFF4C00),
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
                          color: Color(0xFFFF4C00),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: GoogleMap(
                  onTap: (latlng) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateTaskScreen3Map(),
                      ),
                    );
                  },
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
