import 'package:flutter_core_base/logic/domain/entity/base_entity.dart';

abstract class UserEntity<C> implements BaseEntity<C> {
  const UserEntity();

  int get id;

  String get name;

  String get family;

  String? get email;

  String get mobile;

}
