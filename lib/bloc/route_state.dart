part of 'route_bloc.dart';

abstract class RouteState extends Equatable {
  String get routeName;
  const RouteState();

  @override
  List<Object> get props => [];
}

class InitalState extends RouteState {
  @override
  get routeName => 'InitalState';
}

class LoadingRoute extends RouteState {
  @override
  get routeName => 'LoadingRoute';
}

class SelectionRoute extends RouteState {
  final List<Version> versions;

  const SelectionRoute(this.versions);
  @override
  get routeName => 'SelectionRoute';

  @override
  List<Object> get props => [versions];
}

class HomeRoute extends RouteState {
  @override
  get routeName => 'HomeRoute';
}
