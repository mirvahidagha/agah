import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

Choice choiceFromJson(String str) => Choice.fromJson(json.decode(str));

String choiceToJson(Choice data) => json.encode(data.toJson());

class Choice extends Equatable {
  final String title;
  final IconData icon;
  final String category;
  const Choice({this.title, this.icon, this.category});

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        title: json["title"],
        icon: IconData(json["icon"], fontFamily: 'MaterialIcons'),
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "icon": icon.codePoint,
        "category": category,
      };
  @override
  List<Object> get props => [title];
}
