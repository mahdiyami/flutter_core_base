import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final Exception e;

  const Failure(this.e);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure(super.e);
}

class JsonParserFailure extends Failure {
  const JsonParserFailure(super.e);
}

class InternetFailure extends Failure {
  const InternetFailure(super.e);
}

class CacheFailure extends Failure {
  const CacheFailure(super.e);
}

sealed class AppException<T> implements Exception {
  final T error;

  const AppException(this.error);
}

class ServerException<T> extends AppException<T> {
  const ServerException(super.error);
}

class InternetException<T> extends AppException<T> {
  const InternetException(super.error);
}

class TokenException<T> extends AppException<T> {
  const TokenException(super.error);
}

class JsonParserException<T> extends AppException<T> {
  const JsonParserException(super.error);
}

class CacheException<T> extends AppException<T> {
  const CacheException(super.error);
}
