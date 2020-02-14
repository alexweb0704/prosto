import 'dart:convert';

import 'package:prosto/helpers/errors_helper.dart';
import 'package:prosto/helpers/locale_storage_helper.dart';
import 'package:prosto/models/task.dart';
import 'package:http/http.dart' as http;

Future<List<Task>> getTasks(params) async {
  int page = params['page'];
  bool returned = params['returned'];
  print('getTasks method started');
  if (returned == false) {
    return null;
  }
  final token = await LStorage.getItem('token');
  final response = await http.post(
    domain + '/tasks/get/$page',
    headers: {"authorization": "Bearer $token"},
  );

  final jsonTasks = await errorHelper(response, getTasks, {"page": page, "returned": false});
  print(jsonTasks);
  if (jsonTasks.containsKey('tasks')) {
    List<Task> tasks = List();
    for (final task in jsonTasks['tasks']) {
      tasks.add(Task.fromJson(task));
    }
    print(tasks);
    return tasks;
  }
  return null;
}
