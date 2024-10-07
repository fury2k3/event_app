import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);
  final Connectivity connectionChecker;

  @override
  Future<bool> get isConnected async {
    final cx = await connectionChecker.checkConnectivity();
    return !(cx == ConnectivityResult.none);
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
    return connectionChecker.onConnectivityChanged;
  }
}
