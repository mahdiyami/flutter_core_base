import 'package:equatable/equatable.dart';
class FailureParams {
  final String? message;
  final int? code;

  const FailureParams({
    this.message,
    this.code,
  });
}
sealed class Failure extends Equatable {
  final FailureParams? params;

  const Failure ({
    this.params,
  });

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({super.params});
}

class JsonParserFailure extends Failure {
  const JsonParserFailure({super.params});
}

class InternetFailure extends Failure {
  const InternetFailure({super.params});
}

class CacheFailure extends Failure {
  const CacheFailure({super.params});
}

sealed class AppException<T> implements Exception {
  final T? exception;

  const AppException([this.exception]);
}

class ServerException extends AppException {
  const ServerException([super.exception]);
}

class InternetException extends AppException {
  const InternetException([super.exception]);
}

class TokenException extends AppException {
  const TokenException([super.exception]);
}

class JsonParserException extends AppException {
  const JsonParserException([super.exception]);
}

class CacheException extends AppException {
  const CacheException([super.exception]);
}
