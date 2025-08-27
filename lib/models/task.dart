// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  final Task? task;
  final String? message;
  final bool? status;

  TaskModel({
    this.task,
    this.message,
    this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    task: json["task"] == null ? null : Task.fromJson(json["task"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "task": task?.toJson(),
    "message": message,
    "status": status,
  };
}

class Task {
  final String? description;
  final bool? complete;
  final String? owner;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Task({
    this.description,
    this.complete,
    this.owner,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    description: json["description"],
    complete: json["complete"],
    owner: json["owner"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "complete": complete,
    "owner": owner,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
