import 'dart:async';

abstract class ConnectionInformation {
  FutureOr<bool> get hasConnection;
  FutureOr<bool> get wifi;
  FutureOr<bool> get ethernet;
  FutureOr<bool> get mobile;
  FutureOr<bool> get vpn;
}
