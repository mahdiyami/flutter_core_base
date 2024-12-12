import 'package:dartz/dartz.dart';
import 'package:example/features/auth/data/data_source/remote/auth_remote_data.dart';
import 'package:example/features/auth/domain/entities/auth_check.dart';
import 'package:example/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_core_base/logic/data/api_services/error/error.dart';
import 'package:flutter_core_base/logic/domain/usecase/use_case.dart';
import 'package:flutter_core_base/logic/response/base_response.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, BaseResponse>> checkUser(BaseParams params) {
    return perform(() async {
      return authRemoteDataSource.checkUser(params);
    });
  }
}
