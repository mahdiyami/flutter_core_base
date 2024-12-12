import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_core_base/logic/domain/entity/base_entity.dart';

abstract class BaseModel<C> implements BaseEntity<C> {
  const BaseModel._();

  /// This method must be implemented by derived classes.
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError("fromJson implementation must be done by derived classes.");
  }

  /// This method must be implemented by derived classes.
  Map<String, dynamic> toJson();

}
const baseModelFreezed = Freezed(fromJson: true, toJson: true,);



