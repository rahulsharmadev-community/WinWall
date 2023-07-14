import 'dart:convert';

import 'package:equatable/equatable.dart';

class Wallpaper extends Equatable {
  const Wallpaper({
    required this.id,
    required this.width,
    required this.height,
    required this.quality,
    required this.raw,
    required this.thumb,
    required this.providerBy,
  });

  final String id;
  final int width;
  final int height;
  final String quality;
  final String raw;
  final String thumb;
  final String providerBy;

  Wallpaper copyWith({
    String? id,
    int? width,
    int? height,
    String? quality,
    String? raw,
    String? thumb,
    String? providerBy,
  }) =>
      Wallpaper(
        id: id ?? this.id,
        width: width ?? this.width,
        height: height ?? this.height,
        quality: quality ?? this.quality,
        raw: raw ?? this.raw,
        thumb: thumb ?? this.thumb,
        providerBy: providerBy ?? this.providerBy,
      );

  factory Wallpaper.fromJson(String str) => Wallpaper.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Wallpaper.fromMap(Map<String, dynamic> json) => Wallpaper(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        quality: json["quality"],
        raw: json["raw"] ?? 'null',
        thumb: json["thumb"],
        providerBy: json["providerBy"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "width": width,
        "height": height,
        "quality": quality,
        "raw": raw,
        "thumb": thumb,
        "providerBy": providerBy,
      };

  @override
  List<Object?> get props =>
      [id, width, height, quality, raw, thumb, providerBy];
}
