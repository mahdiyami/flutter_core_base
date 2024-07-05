import 'package:cross_file/src/types/base.dart' show XFileBase;
import 'package:dio/dio.dart';
import 'package:flutter_core_base/connection_information/connection_information.dart';

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
  void init({required InterceptorsParam interceptorsParam, required String baseUrl});

  Future<Out> get<Out, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    required FromJson<Out, In> fromJson,
  });

  Future<Out> post<Out, In>(String path,
      {String? baseUrl,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      required FromJson<Out, In> fromJson,
      ProgressCallback? onSendProgress});

  Future<Out> patch<Out, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required FromJson<Out, In> fromJson,
  });

  Future<Out> put<Out, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required FromJson<Out, In> fromJson,
  });

  Future<Out> delete<Out, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required FromJson<Out, In> fromJson,
  });

  dynamic multipartFile(XFileBase file);
}
