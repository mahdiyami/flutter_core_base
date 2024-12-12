

import 'base_response.dart';

class BaseTypeResponseImpl<T> extends BaseTypeResponse<T> {
   const BaseTypeResponseImpl({required super.data});
  factory BaseTypeResponseImpl.fromJson(Map<String , dynamic> value) {
    return BaseTypeResponseImpl(data: value["data"] as T);
  }

  @override
  Map<String, dynamic> toJson(Object? Function(dynamic value) toJsonT) {
     throw UnimplementedError();
  }
}