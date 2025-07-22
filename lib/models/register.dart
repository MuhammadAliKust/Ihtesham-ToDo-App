// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final User? user;
  final String? message;
  final bool? status;

  RegisterModel({
    this.user,
    this.message,
    this.status,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "message": message,
    "status": status,
  };
}

class User {
  final String? name;
  final String? email;
  final String? password;
  final String? id;
  final int? v;

  User({
    this.name,
    this.email,
    this.password,
    this.id,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "_id": id,
    "__v": v,
  };
}
