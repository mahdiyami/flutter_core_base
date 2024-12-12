import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core_base/logic/data/api_services/error/error.dart';
import 'package:flutter_core_base/logic/data/local_data/base_local_request.dart';

@LazySingleton(as: BaseLocalRequest)
class SharedPreferencesLocalRequests extends BaseLocalRequest {
  final SharedPreferences pref;

  SharedPreferencesLocalRequests({required this.pref});

  @override
  Future<void> ensureInitialized() async {}

  @override
  T getData<T>(String key) {
    T? res;
    if (T == String) {
      res = pref.getString(key) as T?;
    }
    if (T == int) {
      res = pref.getInt(key) as T?;
    }
    if (T == double) {
      res = pref.getDouble(key) as T?;
    }
    if (T == bool) {
      res = pref.getBool(key) as T?;
    }
    if (T == List<String>) {
      res = pref.getStringList(key) as T?;
    }
    return performSync(() => res,);

  }

  @override
  Future<void> removeData(String key) async {
    await perform(
      () => pref.remove(key),
    );
  }

  @override
  FutureOr<void> saveData<T>({required T value, required String key}) {
    final result = switch (T) {
      const (String) => pref.setString(key, value as String),
      const (int) => pref.setInt(key, value as int),
      const (double) => pref.setDouble(key, value as double),
      const (bool) => pref.setBool(key, value as bool),
      const (List<String>) => pref.setStringList(key, value as List<String>),
      Type() => throw UnimplementedError(),
    };

    return perform(() => result);
  }
}
