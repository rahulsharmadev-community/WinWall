import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:winwall/ui.design/utils/theme.dart';
import '/logic/cubit/app_config.dart/app_config_cubit.dart';
import 'windows_topactionbar.dart';

const double _kWindowCaptionHeight = 32;

class MaterialWindow extends StatelessWidget {
  final Widget? home;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  const MaterialWindow({
    super.key,
    this.home,
    this.onGenerateInitialRoutes,
    this.onGenerateRoute,
    this.navigatorKey,
    this.scaffoldMessengerKey,
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppConfigCubit>().state;
    return Column(
      children: [
        SizedBox.fromSize(
          size: const Size.fromHeight(_kWindowCaptionHeight),
          child: WindowsTopActionBar(
            themeData: state.theme,
            title: state.appTitle,
          ),
        ),
        Expanded(
          child: MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            home: home,
            onGenerateRoute: onGenerateRoute,
            onGenerateInitialRoutes: onGenerateInitialRoutes,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: scaffoldMessengerKey,
          ),
        )
      ],
    );
  }
}
