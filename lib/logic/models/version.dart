import 'dart:convert';
import 'package:equatable/equatable.dart';

class Version extends Equatable {
  const Version({
    required this.title,
    required this.path,
    required this.version,
  });

  /// eg human
  final String title;

  /// eg human.json, wonder.josn
  final String path;

  /// eg 1.0.0
  final String version;

  Version copyWith({
    String? title,
    String? path,
    String? version,
  }) =>
      Version(
        title: title ?? this.title,
        path: path ?? this.path,
        version: version ?? this.version,
      );

  factory Version.fromJson(String str) => Version.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Version.fromMap(Map<String, dynamic> json) => Version(
        title: json["title"],
        path: json["path"],
        version: json["version"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "path": path,
        "version": version,
      };

  @override
  List<Object?> get props => [title, path, version];
}
