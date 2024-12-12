import 'package:dartz/dartz.dart';
import 'package:flutter_core_base/logic/domain/repository/repository.dart';
import 'package:flutter_core_base/flutter_core_base.dart';

abstract class AuthRepository with RepositoryUtils {
  Future<Either<Failure , BaseResponse>> checkUser(BaseParams params);
}