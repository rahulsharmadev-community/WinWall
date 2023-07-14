import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:winwall/ui.design/utils/theme.dart';

class AppConfigCubit extends HydratedCubit<AppConfig> {
  AppConfigCubit() : super(AppConfig.init());

  @override
  AppConfig? fromJson(Map<String, dynamic> json) => AppConfig.fromMap(json);

  @override
  Map<String, dynamic>? toJson(AppConfig state) => state.toMap();
}

class AppConfig extends Equatable {
  final ThemeMode themeMode;
  final String appTitle;
  const AppConfig(this.appTitle, {required this.themeMode});

  ThemeData get theme => themeMode.index == 1 ? AppTheme.light : AppTheme.dark;

  factory AppConfig.init() =>
      const AppConfig('Win-Wall', themeMode: ThemeMode.dark);

  AppConfig copyWith(
    ThemeMode? themeMode,
    String? appTitle,
  ) =>
      AppConfig(
        appTitle ?? this.appTitle,
        themeMode: themeMode ?? this.themeMode,
      );
  @override
  List<Object> get props => [
        themeMode,
        appTitle,
      ];

  static AppConfig fromMap(Map<String, dynamic> map) => AppConfig(
        map['app_title'],
        themeMode: ThemeMode.values[map['theme_mode']],
      );
  Map<String, dynamic> toMap() => {
        'app_title': appTitle,
        'theme_mode': themeMode.index,
      };
}
