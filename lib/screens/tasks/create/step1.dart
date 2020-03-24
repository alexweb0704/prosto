import 'package:flutter/material.dart';
import 'package:prosto/helpers/services.dart';
import '../../../models/service.dart';
import '../create/step2.dart';

class CreateTaskScreen1 extends StatefulWidget {
  @override
  _CreateTaskScreen1State createState() => _CreateTaskScreen1State();
}

class _CreateTaskScreen1State extends State<CreateTaskScreen1> {
  Future<List<Service>> futureServices = getLocalServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xFF68BB49),
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
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 10,
                      ),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 20.0,
                          ),
                          child: Text(
                            services[index].name,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        splashColor: Color(0x6668BB49),
                        highlightColor: Color(0x5568BB49),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskScreen2(serviceId: services[index].id)),);
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
