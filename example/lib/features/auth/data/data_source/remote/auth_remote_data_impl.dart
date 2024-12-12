import 'dart:async';

import 'package:example/features/auth/data/data_source/local/auth_local_data.dart';
import 'package:example/features/auth/data/data_source/remote/auth_remote_data.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_core_base/flutter_core_base.dart';
const _tokenKey = "TOKEN";
@LazySingleton(as: AuthRemoteDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  Future<void> setToken(BaseParams params) async {
    await localRequest.saveData<String>(value: "", key: _tokenKey);
  }

  @override
  FutureOr<String> getToken(BaseParams params) {
    return localRequest.getData<String>(_tokenKey);
  }

  @override
  FutureOr<void> removeToken(BaseParams params) {
    return localRequest.removeData(_tokenKey);
  }
}
