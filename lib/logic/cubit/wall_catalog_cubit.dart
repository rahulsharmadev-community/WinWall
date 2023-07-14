import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '/logic/models/category.dart';
part 'wall_catalog_state.dart';

class WallCatalogCubit extends HydratedCubit<WallCatalogState> {
  WallCatalogCubit() : super(WallCatalogInitial());

  void setCatalog(List<Category> catalogs) => emit(WallCatalogComplete(
      activeCatalogs: catalogs.map((e) => e.title).toList(),
      catalogs: catalogs,
      lastModifiedAt: DateTime.now()));

  void addCategoryCatalogs(List<Category> categorys) {
    if (state is WallCatalogComplete) {
      var tempState = (state as WallCatalogComplete);
      emit(WallCatalogComplete(
          activeCatalogs: tempState.activeCatalogs,
          catalogs: [...tempState.catalogs, ...categorys],
          lastModifiedAt: DateTime.now()));
    }
  }

  void addActiveCatalog(List<String> string) {
    if (state is WallCatalogComplete) {
      var tempState = (state as WallCatalogComplete);

      emit(WallCatalogComplete(
          activeCatalogs: {...tempState.activeCatalogs, ...string}.toList(),
          catalogs: tempState.catalogs,
          lastModifiedAt: DateTime.now()));
    }
  }

  void removeActiveCatalog(String string) {
    if (state is WallCatalogComplete) {
      var tempState = (state as WallCatalogComplete);
      if (tempState.catalogs.isNotEmpty) {
        var list = tempState.activeCatalogs;
        list.remove(string);
        emit(WallCatalogComplete(
            activeCatalogs: list,
            catalogs: tempState.catalogs,
            lastModifiedAt: DateTime.now()));
      }
    }
  }

  @override
  WallCatalogState? fromJson(Map<String, dynamic> json) {
    switch (json['key'] as String) {
      case 'WallCatalogInitial':
        return WallCatalogInitial();
      case 'WallCatalogLoading':
        return WallCatalogLoading();
      case 'WallCatalogComplete':
        return WallCatalogComplete.fromMap(json['value']);
      default:
        return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WallCatalogState state) => {
        'key': '${state.runtimeType}',
        'value': (state is WallCatalogComplete) ? state.toMap() : null
      };
}
