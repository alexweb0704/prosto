import 'package:flutter/material.dart';
import 'package:prosto/helpers/tasks.dart';
import 'package:prosto/models/task.dart';
import 'package:prosto/screens/tasks/task.dart';
import 'package:prosto/widgets/card.dart';
import '../../../widgets/drawer.dart';

class FindTaskScreen extends StatefulWidget {
  @override
  _FindTaskScreenState createState() => _FindTaskScreenState();
}

class _FindTaskScreenState extends State<FindTaskScreen> {
  Future<List<Task>> futureTasks = getTasks({"page": 1, "returned": true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ProstoDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Найти задание'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_vintage),
          ),
        ],
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: FutureBuilder(
          future: futureTasks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Task> tasks = snapshot.data;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ProstoCard(
                    task: tasks[index],
                    showUser: true,
                    tapHandler: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskScreen(
                            taskId: tasks[index].id,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
