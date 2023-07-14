import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:winwall/core/multi_providers.dart';
import 'package:window_manager/window_manager.dart';
import 'ui.design/utils/materialwindow.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
void main() async {
  await initalSetup();
  runApp(MultiBlocProvider(
    providers: MultiProviders.providers,
    child: MultiBlocListener(
      listeners: MultiProviders.listeners,
      child: MaterialWindow(
        navigatorKey: navigator,
        onGenerateRoute: MultiProviders.onGenerateRoute,
      ),
    ),
  ));
}

/// _______________________________________
Future<void> initalSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: Directory.systemTemp);
}

WindowOptions get windowOptions => const WindowOptions(
      size: Size(1080, 600),
      center: true,
      skipTaskbar: false,
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.hidden,
    );
