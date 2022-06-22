// To parse this JSON data, do
//
//     final datamodel = datamodelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserDataModel articleModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String articleModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.title,
    this.url,
    this.time,
  });

  String? title;
  String? url;
  Timestamp? time;

  UserDataModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    title = data["title"] == null ? null : data["title"];
    url = data["url"] == null ? null : data["url"];
    time = data["time"] == null ? null : data["time"];
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        time: json["time"] == null ? null : json["time"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "time": time == null ? null : time,
      };
}
