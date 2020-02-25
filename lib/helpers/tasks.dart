import 'dart:convert';

import 'package:prosto/helpers/errors_helper.dart';
import 'package:prosto/helpers/token.dart';
import 'package:prosto/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:prosto/main.dart';

Future<List<Task>> getTasks(params) async {
  int page = params['page'];
  print('getTasks method started');
  final token = await getToken();
  final response = await http.post(
    domain + '/tasks/get/$page',
    headers: {"authorization": "Bearer $token"},
  );

  final jsonTasks = await errorHelper(response, getTasks, {"page": page});

  if (jsonTasks is List<Task>) {
    return jsonTasks;
  }

  if (jsonTasks.containsKey('tasks')) {
    List<Task> tasks = List();
    for (final task in jsonTasks['tasks']) {
      print('task: ' + task.toString());
      tasks.add(Task.fromJson(task));
    }
    print(tasks);
    return tasks;
  }
  return null;
}

Future<Task> getTask(params) async {
  int id = params['id'];
  print('getTask method started');
  final token = await getToken();
  final response = await http.get(
    domain + '/task/get/$id',
    headers: {"authorization": "Bearer $token"},
  );

  final jsonTask = await errorHelper(response, getTask, {"id": id});
  print(jsonTask);
  if (jsonTask is Task) {
    return jsonTask;
  }
  if (jsonTask.containsKey('task')) {
    Task task;
    task = Task.fromJson(jsonTask['task']);
    print(task);
    return task;
  }
  return null;
}

Future<Task> updateTask(map) async {
  int id = map['id'];
  final token = await getToken();

  final response = await http.post(
    domain + '/tasks/update/$id',
    headers: {
      "Authorization": "Bearer $token",
      "Content-type": "application/json",
    },
    body: jsonEncode(map),
  );

  final jsonTask = await errorHelper(response, updateTask, map);

  if (jsonTask is Task) {
    return jsonTask;
  }

  if (jsonTask.containsKey('task')) {
    return Task.fromJson(jsonTask['task']);
  }
  return null;
}
