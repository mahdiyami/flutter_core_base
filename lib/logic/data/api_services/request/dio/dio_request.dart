import 'dart:convert';
import 'dart:io';

import 'package:cross_file/src/types/base.dart' show XFileBase;
import 'package:dio/dio.dart';

import '../../../../../flutter_core_base.dart';

@LazySingleton(as: AppRequest)
class DioRequest extends AppRequest {
  Dio _dio;
  final ConnectionInformation _connectionInformation;

  DioRequest(this._connectionInformation) : _dio = Dio();

  @override
  void init({required InterceptorsParam interceptorsParam, required BaseRequestOption option}) {
    _dio = Dio(BaseOptions(headers: option.headers, baseUrl: option.baseUrl, connectTimeout: option.connectTimeout ?? const Duration(seconds: 5)));
    initInterceptors(dio: _dio, params: interceptorsParam);
  }

  Future<Out> _handler<Out extends BaseResponse, In>({required Future<Response> request, required FromJson<Out, In> fromJson}) async {
    if (!await _connectionInformation.hasConnection) {
      throw InternetException(Exception("No internet connection"));
    } else {
      try {
        final res = await request;
        return fromJson.call(jsonDecode(res.data));
      } on DioException catch (e) {
        throw switch (e.response?.statusCode) {
          403 => TokenException(e),
          _ => ServerException(e),
        };
      } catch (e, stackTrace) {
        e.logError(extra: 'Json Parser', stackTrace: stackTrace);
        throw JsonParserException(e);
      }
    }
  }

  @override
  Future<Out> delete<Out extends BaseResponse, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required FromJson<Out, In> fromJson,
  }) =>
      _handler(
          request: _dio.delete<String>('${baseUrl ?? _dio.options.baseUrl}$path', queryParameters: (queryParameters ?? {}), data: data),
          fromJson: fromJson);

  @override
  Future<Out> get<Out extends BaseResponse, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required FromJson<Out, In> fromJson,
    Map<String, dynamic>? headers,
  }) {
    const extra = <String, dynamic>{};

    final options =
        Options(method: 'GET', headers: headers, extra: extra).compose(_dio.options, path, queryParameters: queryParameters, data: data).copyWith(
              baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
            );

    return _handler(
      request: _dio.fetch<String>(_setStreamType<String>(options)),
      fromJson: fromJson,
    );
  }

  @override
  Future<Out> post<Out extends BaseResponse, In>(String path,
      {String? baseUrl,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      required FromJson<Out, In> fromJson,
      ProgressCallback? onSendProgress}) {
    const extra = <String, dynamic>{};
    final options = Options(
      method: 'POST',
      headers: headers,
      extra: extra,
    )
        .compose(
          _dio.options,
          path,
          queryParameters: queryParameters,
          data: data != null ? FormData.fromMap(data) : null,
          onSendProgress: onSendProgress,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ));

    return _handler(
      request: _dio.fetch<String>(_setStreamType<String>(options)),
      fromJson: fromJson,
    );
  }

  @override
  Future<Out> put<Out extends BaseResponse, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required FromJson<Out, In> fromJson,
    Map<String, dynamic>? headers,
  }) =>
      _handler(
        request: _dio.put<String>('${baseUrl ?? _dio.options.baseUrl}$path', queryParameters: (queryParameters ?? {}), data: data),
        fromJson: fromJson,
      );

  @override
  Future<Out> patch<Out extends BaseResponse, In>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required FromJson<Out, In> fromJson,
    Map<String, dynamic>? headers,
  }) {
    const extra = <String, dynamic>{};
    final options = Options(
      method: 'PATCH',
      headers: headers,
      extra: extra,
    )
        .compose(
          _dio.options,
          path,
          queryParameters: queryParameters,
          data: data != null ? FormData.fromMap(data) : null,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ));

    return _handler(
      request: _dio.fetch<String>(_setStreamType<String>(options)),
      fromJson: fromJson,
    );
  }

  @override
  dynamic multipartFile(XFileBase file) {
    return MultipartFile.fromFile(
      file.path,
      filename: file.path.split(Platform.pathSeparator).last,
    );
  }
}

RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
  if (T != dynamic && !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
    if (T == String) {
      requestOptions.responseType = ResponseType.plain;
    } else {
      requestOptions.responseType = ResponseType.json;
    }
  }
  return requestOptions;
}

String _combineBaseUrls(
  String dioBaseUrl,
  String? baseUrl,
) {
  if (baseUrl == null || baseUrl.trim().isEmpty) {
    return dioBaseUrl;
  }

  final url = Uri.parse(baseUrl);

  if (url.isAbsolute) {
    return url.toString();
  }

  return Uri.parse(dioBaseUrl).resolveUri(url).toString();
}
