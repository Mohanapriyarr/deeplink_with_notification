// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  final Data data;
  final Support support;

  DetailsModel({
    required this.data,
    required this.support,
  });

  DetailsModel copyWith({
    Data? data,
    Support? support,
  }) =>
      DetailsModel(
        data: data ?? this.data,
        support: support ?? this.support,
      );

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        data: Data.fromJson(json["data"]),
        support: Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "support": support.toJson(),
      };
}

class Data {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  Data copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      Data(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class Support {
  final String url;
  final String text;

  Support({
    required this.url,
    required this.text,
  });

  Support copyWith({
    String? url,
    String? text,
  }) =>
      Support(
        url: url ?? this.url,
        text: text ?? this.text,
      );

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
