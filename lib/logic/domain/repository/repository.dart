import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_core_base/logic/data/api_services/error/error.dart';

part "error_manager.p.dart";
abstract mixin class RepositoryUtils {
  const RepositoryUtils();

  Future<Either<Failure, T>> perform<T>(Future<T> Function() func) async {
    try {
      return Right(await func());
    } on AppException catch (e) {
      return Left(_handleError(e));
    }
  }

  Either<Failure, T> performSync<T>(T Function() func) {
    try {
      return Right(func());
    } on AppException catch (e) {
      return Left(_handleError(e));
    }
  }

  Failure _handleError(AppException e) {
    return switch (e) {
      ServerException() => ServerFailure(params: e.toFailureParams()),
      TokenException() => ServerFailure(params: e.toFailureParams()),
      JsonParserException() => JsonParserFailure(params: e.toFailureParams()),
      CacheException() => CacheFailure(params: e.toFailureParams()),
      InternetException() => InternetFailure(params: e.toFailureParams()),
    };
  }
}