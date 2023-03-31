import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:oural_go/connection/connection_type.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'improved_internet_state.dart';

class ImprovedInternetCubit extends Cubit<ImprovedInternetState> {
  ImprovedInternetCubit() : super(InternetLoading()) {
    checkStreamForConnection();
  }

  late StreamSubscription internetSubscription;

  void checkStreamForConnection() {
    internetSubscription = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        // Connectivity connectivity = Connectivity();
        // connectivity.onConnectivityChanged.listen((connectivityResult) {
        //   // connectivityResult == ConnectivityResult.wifi
        //   // emit(InternetConnected(connectionType: ConnectionType.wifi));
        // });
        if (status == InternetConnectionStatus.connected) {
          emit(InternetConnected());
        } else {
          emit(InternetDisconnected());
        }
      },
    );
  }
}
