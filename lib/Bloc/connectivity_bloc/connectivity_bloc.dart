import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectedState> {
  bool fistTime = false;

 late StreamSubscription<List<ConnectivityResult>> streamSubscription;
  ConnectivityBloc() : super(const ConnectedState(message: "init")) {
    on<OnConnectedWifi>((event, emit) =>
        emit(const ConnectedState(message: "Connecting To Wifi")));
    on<OnConnectedMobileData>((event, emit) =>
        emit(const ConnectedState(message: "Connecting To Mobile Data")));
    on<OnNotConnected>((event, emit) =>
        emit(const ConnectedState(message: "Lost Internet Connection")));

    streamSubscription = Connectivity().onConnectivityChanged
        
        .listen((List<ConnectivityResult> connectivityResult) {
      if (fistTime) {
        if (connectivityResult.contains(ConnectivityResult.wifi) ) {
          add(OnConnectedWifi());
        } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
          add(OnConnectedMobileData());
        } else {
          add(OnNotConnected());
        }
      }
      fistTime = true;
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
