import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'wallpaper.dart';

class Category extends Equatable {
  final String title;
  final String version;
  final List<Wallpaper> list;
  const Category({
    required this.list,
    required this.title,
    required this.version,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        title: json['title'],
        version: json['version'],
        list: List<dynamic>.from(json['list'])
            .map((e) => Wallpaper.fromMap(e))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'version': version,
        'list': list.map((e) => e.toMap()).toList(),
      };
  @override
  List<Object?> get props => [list, title, version];
}
