import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_core_base/logic/data/api_services/error/error.exp.dart';

abstract class UseCase<Type, Params, PathParams> {
  const UseCase();

  FutureOr<Either<Failure, Type>> call(Params params  , PathParams pathParams);
}

class NoParams extends BaseParams {
  const NoParams._();

  static const _i = NoParams._();

  factory NoParams() => _i;

  @override
  List<Object> get props => [];
}

abstract class BaseParams {
  const BaseParams();
}

const baseParamsFreezed = Freezed(
  fromJson: true,
  toJson: true,
);
