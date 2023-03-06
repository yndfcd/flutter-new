import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<void> check();
}

class NetworkInfoImpl implements NetworkInfo {

  ConnectivityResult result = ConnectivityResult.none;

  @override
  Future<void> check() async {
    result = await Connectivity().checkConnectivity();
  }

  NetworkInfoImpl() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      this.result = result;
    });
  }

  @override
  Future<bool> get isConnected async {
    return result != ConnectivityResult.none;
  }
}