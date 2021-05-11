import 'package:equatable/equatable.dart';
import 'dart:convert';

Site siteFromJson(String str) => Site.fromJson(json.decode(str));

String siteToJson(Site data) => json.encode(data.toJson());

class Site extends Equatable {
  final String title;

  const Site({this.title});

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
  @override
  List<Object> get props => [title];
}
