import 'dart:async';

import 'package:flutter_core_base/flutter_core_base.dart';

abstract class AuthLocalDataSource extends BaseLocalDataSource {
    Future<void> setToken(BaseParams params);
    FutureOr<String> getToken(BaseParams params);
    FutureOr<void> removeToken(BaseParams params);
}