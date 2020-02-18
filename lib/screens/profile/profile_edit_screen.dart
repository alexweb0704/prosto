import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prosto/helpers/users.dart';
import 'package:prosto/models/service.dart';
import 'package:prosto/models/user.dart';
import 'package:prosto/screens/profile/services_select_screen.dart';
import 'package:prosto/widgets/profile_services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  final User user;
  ProfileEditScreen({this.user});
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  Gender gender;
  List<int> servicesId = List();
  List<int> oldServicesId = List();
  List<Gender> items = [
    Gender(code: 'male', name: 'Мужской'),
    Gender(code: 'female', name: 'Женский'),
  ];
  File avatar;
  List<Service> services;
  Future<User> user;
  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.user.username;
    _nameController.text = widget.user.name;
    items.forEach((item) {
      if (item.code == widget.user.gender) {
        setState(() {
          gender = item;
        });
      }
    });
    widget.user.services.forEach((item) {
      servicesId.add(item.id);
    });
    oldServicesId = servicesId;
    _passportController.text = widget.user.passport;
    services = widget.user.services;
  }

  Future<bool> update() async {
    print('user update');
    Map map = Map();
    if (widget.user.username != _usernameController.text) {
      map['username'] = _usernameController.text;
    }
    if (widget.user.name != _nameController.text) {
      map['name'] = _nameController.text;
    }
    if (gender != null && widget.user.gender != gender.code) {
      map['gender'] = gender.code;
    }
    if (widget.user.passport != _passportController.text) {
      map['passport'] = _passportController.text;
    }
    List<int> servicesID = List();

    for (final service in services) {
      servicesID.add(service.id);
    }

    map['services'] = servicesID;

    if (map.isNotEmpty && await updateUser(map)) {
      User user = await getLocalCurrentUser();
      Navigator.pop(
        context,
        {
          'snackBarContent': Text('Ваш профиль обновлен'),
          'snackBarColor': Color(0xFF68BB49),
          'user': user,
        },
      );
      return true;
    }

    return null;
  }

  void _setServices() async {
    final items = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServicesSelectScreen(servicesId),
      ),
    );
    setState(() {
      services = items;
    });

    print(services);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование данных'),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(color: Colors.white),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/icons/user.png',
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 126,
                    child: Transform.scale(
                      scale: .8,
                      child: FloatingActionButton(
                        backgroundColor: Color(0xFF3F4089),
                        mini: true,
                        onPressed: () async {
                          avatar = await ImagePicker.pickImage(
                            source: ImageSource.camera,
                          );
                          print(avatar.uri);
                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        update();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProfileScreen(),
                        //   ),
                        // );
                      },
                      heroTag: 'save-float-btn',
                      mini: true,
                      backgroundColor: Color(0xFF68BB49),
                      child: Icon(Icons.save),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'ФИО',
                  hintText: 'Введте ваше ФИО полностью',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Пол',
                style: TextStyle(fontSize: 16, color: Color(0xAA000000)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DropdownButton(
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item.name),
                  );
                }).toList(),
                underline: Container(
                  height: 1,
                  color: Color(0xFF68BB49),
                ),
                onChanged: (Gender newGender) {
                  setState(() {
                    gender = newGender;
                  });
                },
                selectedItemBuilder: (context) {
                  return items.map<Widget>((item) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(item.name),
                    );
                  }).toList();
                },
                value: gender,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                hint: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Выберите пол')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _passportController,
                decoration:
                    InputDecoration(labelText: 'Серия и номер паспорта'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 10.0,
                right: 20.0,
              ),
              child: TextField(
                controller: _usernameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Номер телефона'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Сфера деятельности',
                style: TextStyle(fontSize: 16, color: Color(0xAA000000)),
              ),
            ),
            ProfileServices(
              services,
              showDeleteButton: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(
                onPressed: _setServices,
                child: Text(
                  'Добавить сферу деятельности',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Gender {
  String code;
  String name;
  Gender({this.code, this.name});
}
