import 'dart:async';

import 'package:flutter_core_base/flutter_core_base.dart';

abstract class BaseLocalRequest {
  String get boxKey => runtimeType.toString();

  void ensureInitialized();

  FutureOr<void> saveData<T>({required T value, required String key});

  T getData<T>(String key);

  Future<void> removeData(String key);

  Future<T> perform<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } catch (e) {
      e.logError(extra: 'CacheException');
      throw CacheException(e);
    }
  }

  T performSync<T>(T? Function() operation) {
    try {
      if(operation() !=null) {
        return operation()!;
      }
      else {
        throw const CacheException();
      }
    } catch (e) {
      e.logError(extra: 'CacheException');
      throw CacheException(e);
    }
  }
}
