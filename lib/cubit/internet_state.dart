part of 'internet_cubit.dart';

class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType? connectionType;

  InternetConnected({this.connectionType});
}

class InternetDisconnected extends InternetState {}
