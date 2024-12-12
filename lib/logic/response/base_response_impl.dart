import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

part 'base_response_impl.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class BaseResponseImpl<T> extends BaseResponse<T> {
  const BaseResponseImpl({
    required super.data,
  });

  factory BaseResponseImpl.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$BaseResponseImplFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$BaseResponseImplToJson(this, toJsonT);
}

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class BasePaginationResponseImpl<T> extends BasePaginationResponse<T> {
  @override
  @JsonKey(fromJson: _fromJsonMeta, toJson: _toJsonMeta)
  final PaginationMeta? meta;

  const BasePaginationResponseImpl({required super.data, this.meta}) : super(meta: meta);

  static PaginationMeta? _fromJsonMeta(Map<String, dynamic>? json) {
    if (json == null) return null;

    return (
      currentPage: json['current_page'] as int? ?? 0,
      from: json['from'] as int? ?? 0,
      to: json['to'] as int? ?? 0,
      lastPage: json['last_page'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 0,
    );
  }

  static Map<String, dynamic>? _toJsonMeta(PaginationMeta? meta) {
    return {
      'current_page': meta?.currentPage,
    };
  }

  factory BasePaginationResponseImpl.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BasePaginationResponseImplFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$BasePaginationResponseImplToJson(this, toJsonT);
}
