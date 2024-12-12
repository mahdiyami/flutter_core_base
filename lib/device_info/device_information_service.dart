import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';


import 'device_information.dart';


@LazySingleton(as: DeviceInformation)
class DeviceInfoService implements DeviceInformation {
  final DeviceInfoPlugin _deviceInfoPlugin;

  DeviceInfoService(this._deviceInfoPlugin);

  @override
  Future<String> get os async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'iOS';
    } else {
      return 'Unknown';
    }
  }

  @override
  Future<String> get osVersion async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.version.release;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.systemVersion;
    } else {
      return 'Unknown';
    }
  }

  @override
  Future<String> get deviceBuildNumber async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.version.incremental;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.utsname.version;
    } else {
      return 'Unknown';
    }
  }

  @override
  Future<String> get deviceModel async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.model;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.utsname.machine;
    } else {
      return 'Unknown';
    }
  }
}
