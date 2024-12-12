import 'package:example/features/auth/data/data_source/remote/auth_remote_data.dart';
import 'package:example/features/auth/data/models/auth_check/auth_check_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_core_base/flutter_core_base.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<BaseResponse> checkUser(BaseParams params) => appRequest.post(
        "/auth/check",
        fromJson: (json) => BaseResponse.fromJson(json as Map<String, dynamic>, (json) => AuthCheckModel.fromJson(json as Map<String, dynamic>)),
      );
}
