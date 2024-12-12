import 'package:flutter_core_base/flutter_core_base.dart';

abstract class AuthRemoteDataSource extends BaseRemoteDataSource {
    Future<BaseResponse> checkUser(BaseParams params);
}