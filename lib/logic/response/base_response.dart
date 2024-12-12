import 'package:equatable/equatable.dart';
import 'package:flutter_core_base/logic/response/base_response_impl.dart';
import 'package:flutter_core_base/logic/response/base_type_response.dart';

abstract class BaseResponse<T> extends Equatable {
  final T data;

  const BaseResponse({required this.data});

  /// This method must be implemented by derived classes.
  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return BaseResponseImpl.fromJson(json, fromJsonT);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [data];

  /// This method must be implemented by derived classes.
  Map<String, dynamic> toJson(Object? Function(dynamic value) toJsonT);
}

class NoResponse extends BaseResponse<void> {
  const NoResponse() : super(data: null);

  @override
  Map<String, dynamic> toJson(Object? Function(dynamic value) toJsonT) {
    return {};
  }
}

typedef PaginationMeta = ({
  int currentPage,
  int from,
  int to,
  int lastPage,
  int total,
  int perPage,
});

abstract class BasePaginationResponse<T> extends BaseResponse<List<T>> {
  const BasePaginationResponse({
    required super.data,
    this.meta,
  });

  factory BasePaginationResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return BasePaginationResponseImpl.fromJson(json, fromJsonT);
  }

  final PaginationMeta? meta;

  bool get isAllItems => meta?.perPage == -1;

  bool get isLast =>
      meta != null ? (meta?.lastPage == meta?.currentPage) || (!isAllItems && data.length < meta!.perPage) || data.isEmpty || isAllItems : false;

  bool get isFirst => meta?.currentPage == 1 || isAllItems;

  @override
  List<Object?> get props => [data, meta];
}

abstract class BaseTypeResponse<T> extends BaseResponse<T> {
  const BaseTypeResponse({
    required super.data,
  });

  factory BaseTypeResponse.fromJson(Map<String, dynamic> json) {
    return BaseTypeResponseImpl.fromJson(json);
  }

  @override
  List<Object?> get props => [data];
}
