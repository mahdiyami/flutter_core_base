// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_impl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseImpl<T> _$BaseResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponseImpl<T>(
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$BaseResponseImplToJson<T>(
  BaseResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
    };

BasePaginationResponseImpl<T> _$BasePaginationResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BasePaginationResponseImpl<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      meta: BasePaginationResponseImpl._fromJsonMeta(
          json['meta'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$BasePaginationResponseImplToJson<T>(
  BasePaginationResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'meta': BasePaginationResponseImpl._toJsonMeta(instance.meta),
    };
