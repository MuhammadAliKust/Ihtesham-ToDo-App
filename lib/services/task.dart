import 'dart:convert';

import 'package:ihtesham_project/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:ihtesham_project/models/task_listing.dart';

class TaskServices {
  String baseUrl = "https://todo-nu-plum-19.vercel.app";

  ///Create Task
  Future<TaskModel> createTask({
    required String token,
    required String description,
  }) async {
    http.Response response = await http.post(
      Uri.parse("$baseUrl/todos/add"),
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
      Uri.parse("$baseUrl/todos/get"),
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
      Uri.parse("$baseUrl/todos/completed"),
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
      Uri.parse("$baseUrl/todos/incomplete"),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }


  ///Delete Task
  Future<bool> deleteTask({
    required String token,
    required String taskID,
  }) async {
    http.Response response = await http.delete(
      Uri.parse("$baseUrl/todos/delete/$taskID"),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Update Task
  Future<bool> updateTask({
    required String token,
    required String taskID,
    required String description,
  }) async {
    http.Response response = await http.patch(
      Uri.parse("$baseUrl/todos/update/$taskID"),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
      body: jsonEncode({'description': description}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw response.reasonPhrase.toString();
    }
  }
}
