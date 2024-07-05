import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_core_base/connection_information/connection_information.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ConnectionInformation)
class ConnectionInformationConnectivity implements ConnectionInformation {
  final Connectivity connectivity;

  ConnectionInformationConnectivity(this.connectivity);

  @override
  Future<bool> get hasConnection async {
    final res = await connectivity.checkConnectivity();
    if (!res.contains(ConnectivityResult.none) ) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> get wifi async {
    final res = await connectivity.checkConnectivity();
    if (res.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> get ethernet async {
    final res = await connectivity.checkConnectivity();
    if (res.contains(ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> get vpn async {
    final res = await connectivity.checkConnectivity();
    if (res.contains(ConnectivityResult.vpn)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  FutureOr<bool> get mobile async {
    final res = await connectivity.checkConnectivity();
    if (res.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }
}
