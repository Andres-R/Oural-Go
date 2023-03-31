part of 'improved_internet_cubit.dart';

class ImprovedInternetState {}

class InternetLoading extends ImprovedInternetState {}

class InternetConnected extends ImprovedInternetState {
  final ConnectionType? connectionType;

  InternetConnected({this.connectionType});
}

class InternetDisconnected extends ImprovedInternetState {}
