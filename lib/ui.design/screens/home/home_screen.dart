import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:window_manager/window_manager.dart';
import 'package:winwall/logic/cubit/wall_catalog_cubit.dart';
import 'package:winwall/logic/models/wallpaper.dart';
import 'package:winwall/ui.design/utils/loading.dart';
import 'home_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    windowManager.startDragging();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallCatalogCubit, WallCatalogState>(
        builder: (context, state) {
      if (state is WallCatalogComplete) {
        var list = state.catalogs
            .map((e) =>
                state.activeCatalogs.contains(e.title) ? e.list : <Wallpaper>[])
            .reduce(
              (v, e) => [...v, ...e],
            );
        print(state.catalogs.length);
        print(list.length);
        return HomeScaffold(
            appBar: const SizedBox(
              width: 600,
              child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            body: SliverChildBuilderDelegate((context, i) {
              return MouseRegion(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(list[i].thumb),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Chip(label: Text('${i + 1}')),
                    ],
                  ),
                ),
              );
            }, childCount: list.length));
      } else if (state is WallCatalogLoading) {
        return const LoadingWidget();
      } else {
        return Center(
          child: Text('$state'),
        );
      }
    });
  }
}
