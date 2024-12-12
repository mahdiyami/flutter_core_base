

import 'package:example/features/auth/domain/entities/auth_check.dart';
import 'package:flutter_core_base/logic/data/model/base_model.dart';

part 'auth_check_model.freezed.dart';
part 'auth_check_model.g.dart';

@baseModelFreezed
class AuthCheckModel extends AuthCheckEntity with _$AuthCheckModel implements BaseModel {
  const AuthCheckModel._() : super();

  const factory AuthCheckModel({
    required bool registered,
    required bool validated,
    required bool hasPassword,

    required UserModel user,
  }) = _AuthCheckModel;

  factory AuthCheckModel.fromJson(Map<String, dynamic> json) => _$$AuthCheckModelImplFromJson(json);
}
