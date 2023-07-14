part of 'wall_catalog_cubit.dart';

abstract class WallCatalogState extends Equatable {
  const WallCatalogState();
}

class WallCatalogInitial extends WallCatalogState {
  @override
  List<Object?> get props => [];
}

class WallCatalogLoading extends WallCatalogState {
  @override
  List<Object?> get props => [];
}

class WallCatalogComplete extends WallCatalogState {
  final List<String> activeCatalogs;
  final List<Category> catalogs;
  final DateTime lastModifiedAt;

  const WallCatalogComplete(
      {required this.catalogs,
      required this.lastModifiedAt,
      required this.activeCatalogs});

  @override
  List<Object?> get props => [catalogs, catalogs, activeCatalogs];

  factory WallCatalogComplete.fromJson(String str) =>
      WallCatalogComplete.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WallCatalogComplete.fromMap(Map<String, dynamic> map) =>
      WallCatalogComplete(
        activeCatalogs: map['activeCatalogs'],
        catalogs: List<dynamic>.from(map['catalogs'])
            .map((e) => Category.fromMap(e))
            .toList(),
        lastModifiedAt:
            DateTime.fromMillisecondsSinceEpoch(map['lastModifiedAt']),
      );

  Map<String, dynamic> toMap() => {
        'activeCatalogs': activeCatalogs,
        'catalogs': catalogs.map((e) => e.toMap()).toList(),
        'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch
      };
}
