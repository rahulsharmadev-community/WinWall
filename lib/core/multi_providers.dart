// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:winwall/ui.design/screens/home/home_screen.dart';
import 'package:winwall/ui.design/screens/selection/selection_screen.dart';
import 'package:winwall/ui.design/utils/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winwall/bloc/route_bloc.dart';
import 'package:winwall/logic/cubit/wall_catalog_cubit.dart';
import 'package:winwall/logic/models/version.dart';
import 'package:winwall/main.dart' show navigator;
import '../logic/cubit/app_config.dart/app_config_cubit.dart';

class MultiProviders {
  // All BlocProviders
  static get providers => [
        BlocProvider<AppConfigCubit>(
          create: (BuildContext context) => AppConfigCubit(),
        ),
        BlocProvider<WallCatalogCubit>(
          create: (BuildContext context) => WallCatalogCubit(),
        ),
        BlocProvider<RouteBloc>(
          create: (BuildContext context) =>
              RouteBloc(context.read<WallCatalogCubit>())
                ..add(StartNavigation()),
        ),
      ];

  static get listeners => <BlocListener>[
        BlocListener<WallCatalogCubit, WallCatalogState>(
          listener: (context, state) => print(state.runtimeType),
        ),
        const BlocListener<RouteBloc, RouteState>(
          listener: routeblocListener,
        ),
      ];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'HomeRoute':
        return MaterialPageRoute(builder: (c) => const HomeScreen());
      case 'SelectionRoute':
        return MaterialPageRoute(
            builder: (c) =>
                SelectionScreen(settings.arguments as List<Version>));
      default:
        return MaterialPageRoute(
            builder: (c) => const LoadingWidget(isScaffold: true));
    }
  }

  static void routeblocListener(BuildContext context, RouteState state) {
    log('routeblocListener');
    if (state is LoadingRoute) {
      navigator.currentState?.pushReplacementNamed(state.routeName);
    } else if (state is HomeRoute) {
      navigator.currentState?.pushReplacementNamed(state.routeName);
    } else if (state is SelectionRoute) {
      navigator.currentState
          ?.pushReplacementNamed(state.routeName, arguments: state.versions);
    }
  }
}
