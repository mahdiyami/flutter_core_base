class BaseRequestOption {
  final Duration? receiveTimeout;
  final Duration? sendTimeout;
  final String? method;
  final Map<String, dynamic>? extra;
  final Map<String, dynamic>? headers;
  final bool? preserveHeaderCase;
  final String? contentType;
  final BaseListFormat? listFormat;
  final bool? followRedirects;
  final int? maxRedirects;
  final bool? persistentConnection;
  final bool? receiveDataWhenStatusError;
  final BaseValidateStatus? validateStatus;
  final BaseResponseType? responseType;
  final Map<String, dynamic> queryParameters;
  final Duration? connectTimeout;
  final String baseUrl;

  BaseRequestOption({
    this.receiveTimeout,
    this.sendTimeout,
    this.method,
    this.extra,
    this.headers,
    this.preserveHeaderCase,
    this.contentType,
    this.listFormat,
    this.followRedirects,
    this.maxRedirects,
    this.persistentConnection,
    this.receiveDataWhenStatusError,
    this.validateStatus,
    this.responseType,
    this.queryParameters = const {},
    this.connectTimeout,
     this.baseUrl = '',
  });
}

enum BaseListFormat {
  /// Comma-separated values.
  /// e.g. (foo,bar,baz)
  csv,

  /// Space-separated values.
  /// e.g. (foo bar baz)
  ssv,

  /// Tab-separated values.
  /// e.g. (foo\tbar\tbaz)
  tsv,

  /// Pipe-separated values.
  /// e.g. (foo|bar|baz)
  pipes,

  /// Multiple parameter instances rather than multiple values.
  /// e.g. (foo=value&foo=another_value)
  multi,

  /// Forward compatibility.
  /// e.g. (foo[]=value&foo[]=another_value)
  multiCompatible,
}

typedef BaseValidateStatus = bool Function(int? status);


/// Indicates which transformation should be applied to the response data.
enum BaseResponseType {
  /// Transform the response data to JSON object only when the
  /// content-type of response is "application/json" .
  json,

  /// Get the response stream directly,
  /// the [Response.data] will be [ResponseBody].
  ///
  /// ```dart
  /// Response<ResponseBody> rs = await Dio().get<ResponseBody>(
  ///   url,
  ///   options: Options(responseType: ResponseType.stream),
  /// );
  stream,

  /// Transform the response data to an UTF-8 encoded [String].
  plain,

  /// Get the original bytes, the [Response.data] will be [List<int>].
  bytes,
}
