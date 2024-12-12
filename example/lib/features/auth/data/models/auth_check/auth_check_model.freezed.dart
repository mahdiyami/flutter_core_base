// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_check_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthCheckModel _$AuthCheckModelFromJson(Map<String, dynamic> json) {
  return _AuthCheckModel.fromJson(json);
}

/// @nodoc
mixin _$AuthCheckModel {
  bool get registered => throw _privateConstructorUsedError;
  bool get validated => throw _privateConstructorUsedError;
  bool get hasPassword => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;

  /// Serializes this AuthCheckModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthCheckModelCopyWith<AuthCheckModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthCheckModelCopyWith<$Res> {
  factory $AuthCheckModelCopyWith(
          AuthCheckModel value, $Res Function(AuthCheckModel) then) =
      _$AuthCheckModelCopyWithImpl<$Res, AuthCheckModel>;
  @useResult
  $Res call(
      {bool registered, bool validated, bool hasPassword, UserModel user});
}

/// @nodoc
class _$AuthCheckModelCopyWithImpl<$Res, $Val extends AuthCheckModel>
    implements $AuthCheckModelCopyWith<$Res> {
  _$AuthCheckModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registered = null,
    Object? validated = null,
    Object? hasPassword = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
      validated: null == validated
          ? _value.validated
          : validated // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPassword: null == hasPassword
          ? _value.hasPassword
          : hasPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthCheckModelImplCopyWith<$Res>
    implements $AuthCheckModelCopyWith<$Res> {
  factory _$$AuthCheckModelImplCopyWith(_$AuthCheckModelImpl value,
          $Res Function(_$AuthCheckModelImpl) then) =
      __$$AuthCheckModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool registered, bool validated, bool hasPassword, UserModel user});
}

/// @nodoc
class __$$AuthCheckModelImplCopyWithImpl<$Res>
    extends _$AuthCheckModelCopyWithImpl<$Res, _$AuthCheckModelImpl>
    implements _$$AuthCheckModelImplCopyWith<$Res> {
  __$$AuthCheckModelImplCopyWithImpl(
      _$AuthCheckModelImpl _value, $Res Function(_$AuthCheckModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registered = null,
    Object? validated = null,
    Object? hasPassword = null,
    Object? user = freezed,
  }) {
    return _then(_$AuthCheckModelImpl(
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
      validated: null == validated
          ? _value.validated
          : validated // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPassword: null == hasPassword
          ? _value.hasPassword
          : hasPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthCheckModelImpl extends _AuthCheckModel {
  const _$AuthCheckModelImpl(
      {required this.registered,
      required this.validated,
      required this.hasPassword,
      required this.user})
      : super._();

  factory _$AuthCheckModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthCheckModelImplFromJson(json);

  @override
  final bool registered;
  @override
  final bool validated;
  @override
  final bool hasPassword;
  @override
  final UserModel user;

  @override
  String toString() {
    return 'AuthCheckModel(registered: $registered, validated: $validated, hasPassword: $hasPassword, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCheckModelImpl &&
            (identical(other.registered, registered) ||
                other.registered == registered) &&
            (identical(other.validated, validated) ||
                other.validated == validated) &&
            (identical(other.hasPassword, hasPassword) ||
                other.hasPassword == hasPassword) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, registered, validated,
      hasPassword, const DeepCollectionEquality().hash(user));

  /// Create a copy of AuthCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCheckModelImplCopyWith<_$AuthCheckModelImpl> get copyWith =>
      __$$AuthCheckModelImplCopyWithImpl<_$AuthCheckModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthCheckModelImplToJson(
      this,
    );
  }
}

abstract class _AuthCheckModel extends AuthCheckModel {
  const factory _AuthCheckModel(
      {required final bool registered,
      required final bool validated,
      required final bool hasPassword,
      required final UserModel user}) = _$AuthCheckModelImpl;
  const _AuthCheckModel._() : super._();

  factory _AuthCheckModel.fromJson(Map<String, dynamic> json) =
      _$AuthCheckModelImpl.fromJson;

  @override
  bool get registered;
  @override
  bool get validated;
  @override
  bool get hasPassword;
  @override
  UserModel get user;

  /// Create a copy of AuthCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCheckModelImplCopyWith<_$AuthCheckModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
