import 'dart:convert';

import 'package:ihtesham_project/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:ihtesham_project/models/task_listing.dart';

class TaskServices {
  ///Create Task
  Future<TaskModel> createTask({
    required String token,
    required String description,
  }) async {
    http.Response response = await http.post(
      Uri.parse("{{TODO_URL}}/todos/add"),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
      body: jsonEncode({"description": description}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get All Task
  Future<TaskListingModel> getAllTask(String token) async {
    http.Response response = await http.get(
      Uri.parse("{{TODO_URL}}/todos/get"),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get Completed Task
  Future<TaskListingModel> getCompletedTask(String token) async {
    http.Response response = await http.get(
      Uri.parse("{{TODO_URL}}/todos/completed"),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get InCompleted Task
  Future<TaskListingModel> getInCompletedTask(String token) async {
    http.Response response = await http.get(
      Uri.parse("{{TODO_URL}}/todos/incomplete"),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }
}
