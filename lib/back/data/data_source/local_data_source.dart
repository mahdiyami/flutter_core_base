import 'dart:async';

import 'package:flutter_core_base/back/error/error.dart';
import 'package:flutter_core_base/logger/log.dart';


abstract class LocalDataSource {
  // late final Box box;
  abstract final String boxKey;

  Future<void> ensureInitialized() async {
    return perform(() async {
      // box = await Hive.openBox(boxKey);
    });
  }

  Future<T> perform<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } catch (e) {
      e.logError(extra: 'CacheException');
      throw CacheException(e);
    }
  }

  T performSync<T>(T Function() operation) {
    try {
      return operation();
    } catch (e) {
      e.logError(extra: 'CacheException');
      throw CacheException(e);
    }
  }

  // Future<void> clear() => perform(() => box.clear());
}
