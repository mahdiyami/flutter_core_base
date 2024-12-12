

import 'package:example/features/auth/domain/entities/user.dart';
import 'package:flutter_core_base/logic/domain/entity/base_entity.dart';

abstract class AuthCheckEntity<C> extends BaseEntity<C> {
  const AuthCheckEntity();

  bool get registered;

  bool get validated;

  bool get hasPassword;

  UserEntity get user;

}