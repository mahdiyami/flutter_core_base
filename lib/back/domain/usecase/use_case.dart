import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core_base/back/error/error.dart';



abstract class UseCase<Type, Params extends BaseParams > {
  const UseCase();

  FutureOr<Either<Failure, Type>> call(Params params);
}

class NoParams extends BaseParams {
  const NoParams._();

  static const _i = NoParams._();

  factory NoParams() => _i;

  @override
  List<Object> get props => [];
}

abstract class BaseParams extends Equatable {
  const BaseParams();
}