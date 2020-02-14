import 'package:flutter/material.dart';
import 'package:prosto/helpers/http_helper.dart';
import 'package:prosto/models/service.dart';

class ServicesSelectScreen extends StatefulWidget {
  final List<Service> selectedServices;
  ServicesSelectScreen(this.selectedServices);
  @override
  _ServicesSelectScreenState createState() => _ServicesSelectScreenState();
}

class _ServicesSelectScreenState extends State<ServicesSelectScreen> {
  Future<List<Service>> futureServices;
  List<Service> selectedServices = List();
  @override
  void initState() {
    super.initState();
    futureServices = HttpHelper.getServices();
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
        child: FutureBuilder(
          future: futureServices,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var services = snapshot.data;
              return ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    bool selected = false;
                    selectedServices.forEach((item) {
                      if (item.id == services[index].id) {
                        setState(() {
                          selected = true;
                        });
                      }
                    });
                    return Card(
                      color: selected ? Theme.of(context).accentColor : null,
                      child: new ListTile(
                        dense: true,
                        title: Text(
                          services[index].name,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: selected ? Colors.white : null,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedServices.add(services[index]);
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
    );
  }
}
