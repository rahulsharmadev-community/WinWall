// ignore_for_file: void_checks

import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:winwall/logic/cubit/wall_catalog_cubit.dart';
import 'package:winwall/logic/models/version.dart';
import '/logic/repos/database_request_repo.dart';
part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteNavigationOn, RouteState> {
  var dataBaseRequestRepo = DataBaseRequestRepo();
  final WallCatalogCubit catalogCubit;
  RouteBloc(this.catalogCubit) : super(LoadingRoute()) {
    on<VersionSelection>((event, emit) async {
      var list = await Future.wait(event.versions
          .map((e) => dataBaseRequestRepo.getWallpaperByCatalogVersion(e))
          .toList());
      catalogCubit.setCatalog(list);
      emit(HomeRoute());
    });
    on<StartNavigation>((event, emit) async {
      if (catalogCubit.state is WallCatalogComplete) {
        await available(catalogCubit.state as WallCatalogComplete, emit);
      } else if (catalogCubit.state is WallCatalogInitial) {
        await notAvailable(emit);
      }
    });
  }
  Future<void> notAvailable(Emitter emit) async {
    var latestVer = await dataBaseRequestRepo.getVersions();
    emit(SelectionRoute(latestVer));
  }

  Future<void> available(WallCatalogComplete state, Emitter emit) async {
    var diff = <Version>[];
    var latestVer = await dataBaseRequestRepo.getVersions();
    var cachedVer = state.catalogs.map((e) => {e.title: e.version}).toList();

    for (var i = 0; i < latestVer.length; i++) {
      var isFound = false;
      for (var cv in cachedVer) {
        var map = cv.entries.first;
        if (map.key == latestVer[i].title &&
            map.value == latestVer[i].version) {
          isFound = true;
          break;
        }
      }
      if (!isFound) diff.add(latestVer[i]);
    }
    log('add json: $diff');
    if (diff.isNotEmpty) {
      var list = await Future.wait(diff
          .map((e) => dataBaseRequestRepo.getWallpaperByCatalogVersion(e))
          .toList());
      catalogCubit.addCategoryCatalogs(list);
      diff = [];
    }

    if (diff.isEmpty) {
      emit(HomeRoute());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
  // Future<void> noCachedAvailable(emit) async {
  //   var latestVer = await dataBaseRequestRepo.getVersions();
  //   emit(SelectionRoute(latestVer));
  // }

  // Future<void> cachedAvailable(WallCatalogComplete cachedState, emit) async {
  //   var diff = <Version>[];
  //   var latestVer = await dataBaseRequestRepo.getVersions();
  //   var cachedVer =
  //       cachedState.catalogs.map((e) => {e.title: e.version}).toList();
  //   for (var i = 0; i < latestVer.length; i++) {
  //     if (!cachedVer.contains({latestVer[i].title: latestVer[i].version})) {
  //       diff.add(latestVer[i]);
  //     }
  //   }
  //   if (diff.isNotEmpty) {
  //     var list = await Future.wait(diff
  //         .map((e) => dataBaseRequestRepo.getWallpaperByCatalogVersion(e))
  //         .toList());
  //     wallCatalogCubit.addCategoryCatalogs(list);
  //     diff = [];
  //   }

  //   if (diff.isEmpty) {
  //     emit(HomeRoute());
  //   }
  // }

}
