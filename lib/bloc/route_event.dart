part of 'route_bloc.dart';

abstract class RouteNavigationOn extends Equatable {
  const RouteNavigationOn();
}

class StartNavigation extends RouteNavigationOn {
  @override
  List<Object?> get props => [];
}

class VersionSelection extends RouteNavigationOn {
  final List<Version> versions;

  const VersionSelection(this.versions);

  @override
  List<Object?> get props => [versions];
}
