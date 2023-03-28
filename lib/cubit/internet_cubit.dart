import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oural_go/connection/connection_type.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

part 'internet_state.dart';

// NOT USED

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({
    required this.connectivity,
  }) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult == ConnectivityResult.wifi) {
          emit(InternetConnected(connectionType: ConnectionType.wifi));
        } else if (connectivityResult == ConnectivityResult.mobile) {
          emit(InternetConnected(connectionType: ConnectionType.mobile));
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(InternetDisconnected());
        }
      },
    );
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
