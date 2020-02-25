import 'package:flutter/material.dart';
import 'package:prosto/helpers/services.dart';
import 'package:prosto/models/list_item.dart';
import 'package:prosto/models/service.dart';

class ServicesSelectScreen extends StatefulWidget {
  final List<int> selectedServices;
  ServicesSelectScreen(this.selectedServices);
  @override
  _ServicesSelectScreenState createState() => _ServicesSelectScreenState();
}

class _ServicesSelectScreenState extends State<ServicesSelectScreen> {
  Future<List<Service>> futureServices = getLocalServices();
  List<int> selectedServices = List();
  List<ListItem> list = List();

  @override
  void initState() {
    super.initState();
    selectedServices = widget.selectedServices;
    futureServices.then((services) {
      for (final service in services) {
        ListItem item = ListItem(service);
        print('selected services: $selectedServices');
        if (selectedServices.contains(item.data.id)) {
          item.isSelected = true;
        }
        list.add(item);
      }
    });
  }

  void _toBack () {
    List<Service> services = List();
    list.forEach((item) {
      if (item.isSelected) {
        services.add(item.data);
      }
    });
    print(services);
    Navigator.pop(context, services);
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
        ),
        centerTitle: true,
        title: Text(
          'Выберите категорию',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 100,
              left: 0,
              right: 0,
              child: FutureBuilder(
                future: futureServices,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: list[index].isSelected
                                ? Theme.of(context).accentColor
                                : null,
                            child: new ListTile(
                              dense: true,
                              title: Text(
                                list[index].data.name,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: list[index].isSelected
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  list[index].isSelected =
                                      !list[index].isSelected;
                                });
                              },
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Positioned(
              height: 50,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FlatButton(
                  onPressed: _toBack,
                  color: Color(0xFF68BB49),
                  textColor: Colors.white,
                  child: Text(
                    'Сохранить',
                    style: TextStyle(
                      fontSize: 20,
                    ),
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
