import 'package:cross_file/src/types/base.dart' show XFileBase;
import 'package:dio/dio.dart';
import 'package:flutter_core_base/connection_information/connection_information.dart';
import 'package:flutter_core_base/logic/response/base_response.dart';

import 'base_request_option.dart';

typedef InterceptorsParam = ({
  void Function(String msg) onErrorMessage,
  void Function(String msg) onResponseMessage,
  MapEntry<String, dynamic> Function() authToken,
  dynamic Function(int code) onAuthError,
  Stream<ConnectionInformation>? connectivityStream,
  Function(String log) logRequest,
  Function(String log) logResponse,
  Function(String log) logError,
});
typedef FromJson<Out, In> = Out Function(In json);

abstract class AppRequest {
  AppRequest();

  void init({required InterceptorsParam interceptorsParam, required BaseRequestOption option});

  Future<Out> get<Out extends BaseResponse, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    required FromJson<Out, In> fromJson,
  });

  Future<Out> post<Out extends BaseResponse, In>(String path,
      {String? baseUrl,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      required FromJson<Out, In> fromJson,
      ProgressCallback? onSendProgress});

  Future<Out> patch<Out extends BaseResponse, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    required FromJson<Out, In> fromJson,
  });

  Future<Out> put<Out extends BaseResponse, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    required FromJson<Out, In> fromJson,
  });

  Future<Out> delete<Out extends BaseResponse, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    required FromJson<Out, In> fromJson,
  });

  dynamic multipartFile(XFileBase file);
}
