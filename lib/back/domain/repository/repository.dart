import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_core_base/back/error/error.dart';


abstract mixin class Repository {
  const Repository();

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
      ServerException() => ServerFailure(e),
      TokenException() => ServerFailure(e),
      JsonParserException() => JsonParserFailure(e),
      CacheException() => CacheFailure(e),
      InternetException() => InternetFailure(e),
    };
  }
}