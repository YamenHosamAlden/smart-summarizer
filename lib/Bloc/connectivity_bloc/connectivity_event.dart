part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}
class OnConnectedWifi extends ConnectivityEvent {}
class OnConnectedMobileData extends ConnectivityEvent {}
class OnNotConnected extends ConnectivityEvent {}