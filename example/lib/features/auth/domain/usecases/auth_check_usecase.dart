import 'package:dartz/dartz.dart';
import 'package:example/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_core_base/flutter_core_base.dart';

@LazySingleton()
class AuthCheckUseCase extends UseCase<BaseResponse, BaseParams> {
  final AuthRepository _repository;

  const AuthCheckUseCase(this._repository);

  @override
  Future<Either<Failure, BaseResponse>> call(BaseParams params) => _repository.checkUser(params);
}
