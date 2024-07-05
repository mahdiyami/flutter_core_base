import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/rendering.dart';
import 'package:flutter_core_base/back/request/request.dart';
import 'package:flutter_core_base/connection_information/connection_information.dart';



Dio initInterceptors({required Dio dio, required InterceptorsParam params}) => dio
  //remove all interceptors
  ..interceptors.removeWhere((element) => true)
  //add new item
  ..interceptors.addAll([
    _$OnResponseJsonParserInterceptor(keyData: 'results'),
    _$OnMessageHandlerInterceptor(
      onErrorMessage: params.onErrorMessage,
      onResponseMessage: params.onResponseMessage,
    ),
    _$LoggerInterceptor(
      logError: params.logError,
      logRequest: params.logRequest,
      logResponse: params.logResponse,
    ),
    _$AuthInterceptor(
      authToken: params.authToken,
      onAuthError: params.onAuthError,
    ),
    _$RetryInterceptor(
      dio,
      max: 5,
      extraTimeOut: 2000,
      tryCountKey: 'try_Count_key',
    ),
    if (params.connectivityStream != null)
      _$RetryOnConnectionChangeInterceptor(
        params.connectivityStream!,
        dio,
      )
  ]);

final class _$RetryOnConnectionChangeInterceptor extends Interceptor {
  final Stream<ConnectionInformation> connectivityStream;
  final Dio _dio;
  static const String _key = 'RetryOnConnectionChangeInterceptorKEY';

  _$RetryOnConnectionChangeInterceptor(this.connectivityStream, this._dio);

  @override
  Future<dynamic> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        err.requestOptions.extra.addAll({_key: true});
        var res = await dioConnectivityRequestRetry(requestOptions: err.requestOptions);
        return handler.resolve(res);
      } on DioException catch (e) {
        // Let any new error from the retried pass through
        // return handler.next(e);
        super.onError(e, handler);
      }
    }
    // Let the error pass through if it's not the error we're looking for
    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.requestOptions.extra[_key] == null &&
        err.type == DioExceptionType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }

  Future<Response> dioConnectivityRequestRetry({required RequestOptions requestOptions}) {
    final responseCompleter = Completer<Response>();
    late final StreamSubscription streamSubscription;
    cancel() {
      streamSubscription.cancel();
    }

    streamSubscription = connectivityStream.listen((connectivityResult) async {
      if (!await connectivityResult.hasConnection) {
        cancel();
        // Complete the completer instead of returning
        responseCompleter.complete(
          _dio.fetch(requestOptions),
        );
      }
    });

    return responseCompleter.future;
  }

// get response =>;
}

final class _$RetryInterceptor extends Interceptor {
  final String tryCountKey;

  ///in second [extraTimeOut]
  final int extraTimeOut;
  final int max;

  final Dio _dio;

  _$RetryInterceptor(
    this._dio, {
    this.max = 5,
    this.extraTimeOut = 2000,
    this.tryCountKey = '_MAX_TRY_COUNT_KEY retry-interceptor',
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    int temp = options.extra[tryCountKey] ?? 0;

    int tryCount = (temp) + 1;
    options.extra.addEntries([
      MapEntry(tryCountKey, tryCount),
    ]);
    return super.onRequest(options, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.type case DioExceptionType.connectionTimeout

        //if upload of download big files it causes some errors
        //
        //         || DioExceptionType.sendTimeout
        //         || DioExceptionType.receiveTimeout
        ) {
      int tryCount = err.requestOptions.extra[tryCountKey] ?? 0;
      var connectTimeout = err.requestOptions.connectTimeout;

      if (tryCount <= max) {
        try {
          err.requestOptions.extra.addAll({tryCountKey: tryCount + 1});
          var reqOpt = err.requestOptions.copyWith(
            connectTimeout:
                Duration(milliseconds: extraTimeOut + (connectTimeout?.inMilliseconds ?? 0)),
          );
          var res = await _dio.fetch(reqOpt);
          return handler.resolve(res);
        } on DioException catch (e) {
          super.onError(e, handler);
        }
      }
    } else {
      super.onError(err, handler);
    }
  }
}

final class _$AuthInterceptor extends Interceptor {
  ///add to header for auth which user requested
  final MapEntry<String, dynamic> Function() authToken;

  ///error code auth form server
  ///default [int code] is 401
  ///what should i do when auth error code happen
  final Function(int code) onAuthError;

  const _$AuthInterceptor({required this.authToken, required this.onAuthError});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addEntries([authToken()]);

    options.headers = options.headers.map((key, value) => MapEntry(key.toLowerCase(), value));
    return super.onRequest(options, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != null) {
      onAuthError(err.response!.statusCode!);
    }
    super.onError(err, handler);
  }
}

///add this interceptor as first interceptor
final class _$OnResponseJsonParserInterceptor extends Interceptor {
  final String keyData;

  _$OnResponseJsonParserInterceptor({this.keyData = 'json'});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint(response.data.runtimeType.toString());
    var parsed;
    if (response.data is String) {
      try {
        final tag = 'parsing response=> ${response.requestOptions.path}';
        final msg = response.data.toString();
        parsed = await compute(_decoder, msg, debugLabel: tag);
      } catch (_) {}
    } else {
      parsed = response.data;
    }
    response.extra.addAll({keyData: parsed});
    super.onResponse(response, handler);
  }

  static T _decoder<T>(String s) => json.decode(s);
}

final class _$OnMessageHandlerInterceptor extends Interceptor {
  final void Function(String message) onResponseMessage;
  final void Function(String message) onErrorMessage;
  static String? _lastMessage;
  static Timer? _timer;

  const _$OnMessageHandlerInterceptor(
      {required this.onErrorMessage, required this.onResponseMessage});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      var message = response.extra['results']?['message'];

      if((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 && message != null && response.requestOptions.method != "GET"){
        onResponseMessage(message);

      }else {
        if (message != null && response.requestOptions.method != "GET") {
          onErrorMessage(message);

        }
      }
    } catch (_) {}
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.message != null) {
      bool msgHasText = err.message!.isNotEmpty;
      bool newErrorMessage = _lastMessage != err.message;

      if (msgHasText && newErrorMessage) {
        _lastMessage = err.message;
        _timer?.cancel();
        _startTimer();
      }
    }
    try {
      var message = jsonDecode(err.response?.data)['message'];
        if(message != null) {
          onErrorMessage(message);
        }

    } catch (_) {}
    super.onError(err, handler);
  }

  static void _startTimer() {
    _timer = Timer(const Duration(seconds: 5), _cleanLastMessage);
  }

  static void _cleanLastMessage() {
    _lastMessage = null;
  }
}

final class _$LoggerInterceptor extends Interceptor {
  final Function(String) logRequest;
  final Function(String) logResponse;
  final Function(String) logError;

  static final Map<String, int> mapRequests = {};
  static final Map<String, Map<String, int>> mapError = {};
  static const _timeRequestStartKey = '_time_start_req_aas9u8adidas90dually_';

  _$LoggerInterceptor(
      {required this.logRequest, required this.logResponse, required this.logError});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra.addAll({_timeRequestStartKey: DateTime.now().toString()});

    var connectTimeout = options.connectTimeout;
    String uri = options.path.toString();
    int value = mapRequests[uri] ?? 0;
    mapRequests.addAll({uri: value + 1});
    logRequest('>>🌓onRequest uri=>$uri  count => ${value + 1} [ConnectTimeOut:$connectTimeout]');
    logRequest(options.toPrintString());

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var options = response.requestOptions;
    var connectTimeout = options.connectTimeout;
    var duration = DateTime.now().difference(
      DateTime.parse(options.extra[_timeRequestStartKey].toString()),
    );
    String uri = options.path.toString();
    int value = mapRequests[uri] ?? 0;
    mapRequests.addAll({uri: value + 1});
    logResponse(
        '>>😍onResponse uri=>$uri  count => ${value + 1} [ ConnectTimeOut:$connectTimeout , duration in MilliSeconds: ${duration.inMilliseconds}]');
    logResponse(options.toPrintString());

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String uri = err.requestOptions.path.toString();
    Map<String, int> errorOfUri = mapError[uri] ?? {};
    int value = errorOfUri[err.type.name] ?? 0;
    errorOfUri.addAll({err.type.name: value + 1});
    mapError.addAll({uri: errorOfUri});
    var duration = DateTime.now().difference(
      DateTime.parse(err.requestOptions.extra[_timeRequestStartKey].toString()),
    );
    String response = err.type == DioExceptionType.badResponse ? err.response.toString() : '';
    response = response.substring(0, min(response.length, 200));

    logError(
        '>>🤬onError uri=>$uri  error=> ${err.type.name}  count call=> ${value + 1}  duration in MilliSeconds: ${duration.inMilliseconds}  ; response_error=> [$response]');
    logError(err.requestOptions.toPrintString());

    super.onError(err, handler);
  }
}

extension _Log on RequestOptions {
  toPrintString() {
    // String? method=method.toString();
    // int? sendTimeout=sendTimeout.toString();
    // int? receiveTimeout=receiveTimeout.toString();
    // int? connectTimeout=connectTimeout.toString();
    // dynamic data=data.toString();
    // String? path=path.toString();
    // Map<String, dynamic>? queryParameters=queryParameters.toString();
    // String? baseUrl=baseUrl.toString();
    // ProgressCallback? onReceiveProgress=onReceiveProgress.toString();
    // ProgressCallback? onSendProgress=onSendProgress.toString();
    // CancelToken? cancelToken=cancelToken.toString();
    // Map<String, dynamic>? extra=extra.toString();
    // Map<String, dynamic>? headers=headers.toString();
    // ResponseType? responseType=responseType.toString();
    // String? contentType=contentType.toString();
    // ValidateStatus? validateStatus=validateStatus.toString();
    // bool? receiveDataWhenStatusError=receiveDataWhenStatusError.toString();
    // bool? followRedirects=followRedirects.toString();
    // int? maxRedirects=maxRedirects.toString();
    // RequestEncoder? requestEncoder=requestEncoder.toString();
    // ResponseDecoder? responseDecoder=responseDecoder.toString();
    // ListFormat? listFormat=listFormat.toString();
    // bool? setRequestContentTypeWhenNoPayload=setRequestContentTypeWhenNoPayload.toString();

    return '''
   method=>${method.toString()}
sendTimeout=>${sendTimeout.toString()}
receiveTimeout=>${receiveTimeout.toString()}
connectTimeout=>${connectTimeout.toString()}
data=>${data.toString()}
headers=>${headers.toString()}


''';
  }
}
