import 'package:flutter/material.dart';
import 'package:prosto/models/service.dart';

class ProfileServices extends StatefulWidget {
  final List<Service> services;
  final bool showDeleteButton;
  final Function deleteHandler;
  ProfileServices(
    this.services, {
    this.showDeleteButton: false,
    this.deleteHandler,
  });
  @override
  _ProfileServicesState createState() => _ProfileServicesState();
}

class _ProfileServicesState extends State<ProfileServices> {
  List<Widget> _map(List<Service> services) {
    List<Widget> widgets = List();
    for (final service in services) {
      widgets.add(
        ListTile(
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          title: Text(
            service.name,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          trailing: widget.showDeleteButton
              ? IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Color(0xFF3F4089),
                  ),
                  alignment: Alignment.bottomCenter,
                  onPressed: () {
                    widget.deleteHandler(service);
                  },
                )
              : null,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _map(widget.services),
    );
  }
}
