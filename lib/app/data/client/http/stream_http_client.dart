import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:logging/logging.dart';

import '../../../utils/utils.dart';
import 'interceptor/additional_headers_interceptor.dart';
import 'interceptor/logging_interceptor.dart';

part 'stream_http_client_options.dart';

/// This is where we configure the base url, headers,
///  query parameters and convenient methods for http verbs with error parsing.
class StreamHttpClient {
  /// [StreamHttpClient] constructor
  StreamHttpClient({
    Dio? dio,
    StreamHttpClientOptions? options,
    Logger? logger,
  })  : _options = options ?? const StreamHttpClientOptions(),
        httpClient = dio ?? Dio() {
    httpClient
      ..options.baseUrl = _options.baseUrl
      ..options.receiveTimeout = _options.receiveTimeout
      ..options.connectTimeout = _options.connectTimeout
      ..options.queryParameters = {
        ..._options.queryParameters,
      }
      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ..._options.headers,
      }
      ..interceptors.addAll([
        AdditionalHeadersInterceptor(),
        if (logger != null && logger.level != Level.OFF)
          LoggingInterceptor(
            requestHeader: true,
            logPrint: (step, message) {
              switch (step) {
                case InterceptStep.request:
                  return logger.info(message);
                case InterceptStep.response:
                  return logger.info(message);
                case InterceptStep.error:
                  return logger.severe(message);
              }
            },
          ),
      ]);
  }

  /// Your project Stream Chat ClientOptions
  final StreamHttpClientOptions _options;

  /// [Dio] httpClient
  /// It's been chosen because it's easy to use
  /// and supports interesting features out of the box
  /// (Interceptors, Global configuration, FormData, File downloading etc.)

  final Dio httpClient;

  /// Shuts down the [StreamHttpClient].
  ///
  /// If [force] is `false` the [StreamHttpClient] will be kept alive
  /// until all active connections are done. If [force] is `true` any active
  /// connections will be closed to immediately release all resources. These
  /// closed connections will receive an error event to indicate that the client
  /// was shut down. In both cases trying to establish a new connection after
  /// calling [close] will throw an exception.
  void close({bool force = false}) => httpClient.close(force: force);

  /// Handy method to make http GET request with error parsing.
  Future<Response<T>> get<T>(String path,
      {Map<String, Object?>? queryParameters,
      Map<String, Object?>? headers,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      required bool showProgress}) async {
    try {
      if (showProgress) {
        Future.delayed(Duration.zero, () async {
          Utils.showProgressDialog(getx.Get.context!);
        });
      }
      final response = await httpClient.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      if (showProgress) getx.Get.back();
      return response;
    } on DioException {
      if (showProgress) getx.Get.back();
      rethrow;
    }
  }

  /// Handy method to make http POST request with error parsing.
  Future<Response<T>> post<T>(String path,
      {dynamic data,
      Map<String, Object?>? queryParameters,
      Map<String, Object?>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      required bool showProgress}) async {
    try {
      if (showProgress) {
        Future.delayed(Duration.zero, () async {
          Utils.showProgressDialog(getx.Get.context!);
        });
      }
      final response = await httpClient.post<T>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      if (showProgress) getx.Get.back();
      return response;
    } on DioException {
      if (showProgress) getx.Get.back();
      rethrow;
    }
  }

  /// Handy method to make http DELETE request with error parsing.
  Future<Response<T>> delete<T>(String path,
      {Map<String, Object?>? queryParameters,
      Map<String, Object?>? headers,
      CancelToken? cancelToken,
      required bool showProgress}) async {
    try {
      if (showProgress) {
        Future.delayed(Duration.zero, () async {
          Utils.showProgressDialog(getx.Get.context!);
        });
      }
      final response = await httpClient.delete<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      if (showProgress) getx.Get.back();
      return response;
    } on DioException {
      if (showProgress) getx.Get.back();
      rethrow;
    }
  }

  /// Handy method to make http PATCH request with error parsing.
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await httpClient.patch<T>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// Handy method to make http PUT request with error parsing.
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await httpClient.put<T>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }


  /// Handy method to make generic http request with error parsing.
  Future<Response<T>> request<T>(
    String path, {
    Object? data,
    Map<String, Object?>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await httpClient.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
