import 'package:freezed_annotation/freezed_annotation.dart';

abstract class BaseEntity<T> {
  const BaseEntity();

  T get copyWith;
 }

