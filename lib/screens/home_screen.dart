import 'package:flutter/material.dart';
import 'package:prosto/screens/tasks/find/find_task.dart';
import '../screens/tasks/create/step1.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ProstoDrawer(),
      drawerScrimColor: Color(0x5500AE68),
      appBar: AppBar(
        primary: true,
        centerTitle: true,
        title: Container(
          height: 50,
          width: 136,
          child: Image.asset(
            'assets/icons/logo.png',
            height: 33,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: RaisedButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTaskScreen1(),
                    ),
                  );
                },
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Создать задание',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.format_list_numbered,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: RaisedButton(
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindTaskScreen(),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Найти задание',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.search,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
