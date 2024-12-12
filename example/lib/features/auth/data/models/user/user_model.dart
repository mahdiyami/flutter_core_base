import 'package:example/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_core_base/logic/data/model/base_model.dart';
import 'package:flutter_core_base/flutter_core_base.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@baseModelFreezed
class UserModel extends UserEntity with _$UserModel implements BaseModel {
  const UserModel._() : super();

  const factory UserModel({
    required int id,
    required String name,
    required String family,
    String? email,
    required String mobile,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$$UserModelImplFromJson(json);
}


