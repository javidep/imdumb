import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_performance/firebase_performance.dart';

class DioFirebasePerformanceInterceptor extends Interceptor {
  DioFirebasePerformanceInterceptor({
    this.requestContentLengthMethod = defaultRequestContentLength,
    this.responseContentLengthMethod = defaultResponseContentLength,
  });

  /// key: requestKey hash code, value: ongoing metric
  final _map = <int, Trace>{};
  final RequestContentLengthMethod requestContentLengthMethod;
  final ResponseContentLengthMethod responseContentLengthMethod;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.connectTimeout = 30000 as Duration?;
      log(options.path);
      final metric = FirebasePerformance.instance.newTrace(options.uri.normalized());
      final requestKey = options.extra.hashCode;
      _map[requestKey] = metric;
      await metric.start();
    } catch (_) {}
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      final requestKey = response.requestOptions.extra.hashCode;
      final metric = _map[requestKey];
      await metric?.stop();
      _map.remove(requestKey);
    } catch (_) {}
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      err.requestOptions.path;
      err.requestOptions.method;
      final requestKey = err.requestOptions.extra.hashCode;

      final metric = _map[requestKey];
      await metric?.stop();
      _map.remove(requestKey);
    } catch (_) {}
    return super.onError(err, handler);
  }
}

typedef RequestContentLengthMethod = int? Function(RequestOptions options);
int? defaultRequestContentLength(RequestOptions options) {
  try {
    if (options.data is String || options.data is Map) {
      return options.headers.toString().length + (options.data?.toString().length ?? 0);
    }
  } catch (_) {
    return null;
  }
  return null;
}

typedef ResponseContentLengthMethod = int? Function(Response options);
int? defaultResponseContentLength(Response response) {
  if (response.data is String) {
    return (response.headers.toString().length) + response.data.length as int?;
  } else {
    return null;
  }
}

extension _ResponseHttpMetric on HttpMetric {}

extension _UriHttpMethod on Uri {
  String normalized() {
    return "$scheme://$host$path";
  }
}

class DioErrorException implements Exception {
  DioErrorException({
    required this.requestOptions,
    this.response,
    this.type = DioExceptionType.badResponse,
    this.error,
  });

  RequestOptions requestOptions;
  Response? response;
  DioExceptionType type;
  dynamic error;
  StackTrace? _stackTrace;

  String get message => (error?.toString() ?? '');

  @override
  String toString() {
    var msg = '\nrequest : ${requestOptions.path}\nmessage: ${response?.data['message'] ?? "Sin mensaje"}';
    msg += ' \nError: ${response?.data['error'] ?? "Sin mensaje"} ';
    msg += ' \nBody: ${requestOptions.data ?? ""} \nqueryParameters: ${requestOptions.queryParameters.toString()} ';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    if (_stackTrace != null) {
      msg += '\nSource stack:\n$_stackTrace';
    }
    return msg;
  }
}
