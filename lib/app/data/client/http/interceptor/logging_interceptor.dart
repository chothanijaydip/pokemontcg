// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

import 'dart:developer';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import '../../../../utils/utils.dart';

/// Step where we're logging
enum InterceptStep {
  /// Request
  request,

  /// Response
  response,

  /// Error
  error,
}

/// Function used to print the log
typedef LogPrint = void Function(InterceptStep step, Object object);

void _defaultLogPrint(InterceptStep step, Object object) =>
    log(object.toString());

/// Interceptor dedicated to logging
class LoggingInterceptor extends Interceptor {
  /// Initialize a new logging interceptor
  LoggingInterceptor({
    this.request = true,
    this.requestHeader = false,
    this.requestBody = true,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.maxWidth = 120,
    this.compact = true,
    this.logPrint = _defaultLogPrint,
  });

  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// InitialTab count to logPrint json response
  static const int initialTab = 1;

  /// 1 tab length
  static const String tabStep = '    ';

  /// Print compact json response
  final bool compact;

  /// Width size per logPrint
  final int maxWidth;

  /// Log printer; defaults logPrint log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  void Function(InterceptStep step, Object object) logPrint;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (request) {
      _printRequestHeader(_logPrintRequest, options);
    }
    if (requestHeader) {
      _printMapAsTable(
        _logPrintRequest,
        options.queryParameters,
        header: 'Query Parameters',
      );
      final requestHeaders = <String, Object?>{...options.headers};
      requestHeaders['contentType'] = options.contentType?.toString();
      requestHeaders['responseType'] = options.responseType.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      requestHeaders['connectTimeout'] = options.connectTimeout;
      requestHeaders['receiveTimeout'] = options.receiveTimeout;
      _printMapAsTable(_logPrintRequest, requestHeaders, header: 'Headers');
      _printMapAsTable(_logPrintRequest, options.extra, header: 'Extras');
    }
    if (requestBody && options.method != 'GET') {
      final dynamic data = options.data;
      if (data != null) {
        if (data is Map) {
          _printMapAsTable(
            _logPrintRequest,
            options.data as Map?,
            header: 'Body',
          );
        } else if (data is FormData) {
          final formDataMap = <String, dynamic>{}
            ..addEntries(data.fields)
            ..addEntries(data.files);
          _printMapAsTable(
            _logPrintRequest,
            formDataMap,
            header: 'Form data | ${data.boundary}',
          );
        } else {
          _printBlock(_logPrintRequest, data.toString());
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (error) {
      if (err.type == DioExceptionType.badResponse) {
        final uri = err.response?.requestOptions.uri;
        _printBoxed(
          _logPrintError,
          header:
              'DioError ║ Status: ${err.response?.statusCode} ${err.response?.statusMessage}',
          text: uri.toString(),
        );
        if (err.response != null && err.response?.data != null) {
          _logPrintError('╔ ${err.type.toString()}');
          _printResponse(_logPrintError, err.response!);
        }
        _printLine(_logPrintError, '╚');
        _logPrintError('');
        if (err.response?.statusCode == 500) {
          Utils.showShortToast(message: "Internal Server Error");
        } else if (err.response?.statusCode == 403) {
          Utils.showShortToast(message: "Session Expired Please log in again.");
        } else if (err.response?.statusCode == 422) {
          Utils.showShortToast(message: err.response!.data.toString());
        } else if (err.response?.statusCode == 700) {
          Utils.showShortToast(message: "Session Expired Please log in again.");
        }
      } else {
        _printBoxed(
          _logPrintError,
          header: 'DioError ║ ${err.type}',
          text: err.message,
        );
        if (err.response?.statusCode == 500) {
          Utils.showShortToast(message: "Internal Server Error");
        }
        _printRequestHeader(_logPrintError, err.requestOptions);
      }
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printResponseHeader(_logPrintResponse, response);
    if (responseHeader) {
      final responseHeaders = <String, String>{};
      response.headers
          .forEach((k, list) => responseHeaders[k] = list.toString());
      _printMapAsTable(_logPrintResponse, responseHeaders, header: 'Headers');
    }

    if (responseBody) {
      _logPrintResponse('╔ Body');
      _logPrintResponse('║');
      _printResponse(_logPrintResponse, response);
      _logPrintResponse('║');
      _printLine(_logPrintResponse, '╚');
    }
    super.onResponse(response, handler);
  }

  void _printBoxed(
    void Function(Object) logPrint, {
    String? header,
    String? text,
  }) {
    logPrint('');
    logPrint('╔╣ $header');
    logPrint('║  $text');
    _printLine(logPrint, '╚');
  }

  void _printResponse(void Function(Object) logPrint, Response response) {
    if (response.data != null) {
      if (response.data is Map) {
        _printPrettyMap(logPrint, response.data as Map);
      } else if (response.data is List) {
        logPrint('║${_indent()}[');
        _printList(logPrint, response.data as List);
        logPrint('║${_indent()}[');
      } else {
        _printBlock(logPrint, response.data.toString());
      }
    }
  }

  void _printResponseHeader(void Function(Object) logPrint, Response response) {
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;
    _printBoxed(
      logPrint,
      header:
          'Response ║ $method ║ Status: ${response.statusCode} ${response.statusMessage}',
      text: uri.toString(),
    );
  }

  void _printRequestHeader(
    void Function(Object) logPrint,
    RequestOptions options,
  ) {
    final uri = options.uri;
    final method = options.method;
    _printBoxed(logPrint, header: 'Request ║ $method ', text: uri.toString());
  }

  void _printLine(
    void Function(Object) logPrint, [
    String pre = '',
    String suf = '╝',
  ]) =>
      logPrint('$pre${'═' * maxWidth}$suf');

  void _printKV(void Function(Object) logPrint, String? key, Object? v) {
    final pre = '╟ $key: ';
    final msg = v.toString();

    if (pre.length + msg.length > maxWidth) {
      logPrint(pre);
      _printBlock(logPrint, msg);
    } else {
      logPrint('$pre$msg');
    }
  }

  void _printBlock(void Function(Object) logPrint, String msg) {
    final lines = (msg.length / maxWidth).ceil();
    for (var i = 0; i < lines; ++i) {
      logPrint((i >= 0 ? '║ ' : '') +
          msg.substring(
            i * maxWidth,
            math.min<int>(i * maxWidth + maxWidth, msg.length),
          ));
    }
  }

  String _indent([int tabCount = initialTab]) => tabStep * tabCount;

  void _printPrettyMap(
    void Function(Object) logPrint,
    Map data, {
    int tabs = initialTab,
    bool isListItem = false,
    bool isLast = false,
  }) {
    var tabs0 = tabs;
    final isRoot = tabs0 == initialTab;
    final initialIndent = _indent(tabs0);
    tabs0++;

    if (isRoot || isListItem) logPrint('║$initialIndent{');

    data.keys.toList().asMap().forEach((index, dynamic key) {
      final isLast = index == data.length - 1;
      dynamic value = data[key];
      if (value is String) {
        value = '"${value.toString().replaceAll(RegExp(r'(\r|\n)+'), " ")}"';
      }
      if (value is Map) {
        if (compact) {
          logPrint('║${_indent(tabs0)} $key: $value${!isLast ? ',' : ''}');
        } else {
          logPrint('║${_indent(tabs0)} $key: {');
          _printPrettyMap(logPrint, value, tabs: tabs0);
        }
      } else if (value is List) {
        if (compact) {
          logPrint('║${_indent(tabs0)} $key: ${value.toString()}');
        } else {
          logPrint('║${_indent(tabs0)} $key: [');
          _printList(logPrint, value, tabs: tabs0);
          logPrint('║${_indent(tabs0)} ]${isLast ? '' : ','}');
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        final indent = _indent(tabs0);
        final linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          final lines = (msg.length / linWidth).ceil();
          for (var i = 0; i < lines; ++i) {
            logPrint('║${_indent(tabs0)} ${msg.substring(
              i * linWidth,
              math.min<int>(i * linWidth + linWidth, msg.length),
            )}');
          }
        } else {
          logPrint('║${_indent(tabs0)} $key: $msg${!isLast ? ',' : ''}');
        }
      }
    });

    logPrint('║$initialIndent}${isListItem && !isLast ? ',' : ''}');
  }

  void _printList(
    void Function(Object) logPrint,
    List list, {
    int tabs = initialTab,
  }) {
    list.asMap().forEach((i, dynamic e) {
      final isLast = i == list.length - 1;
      if (e is Map) {
        if (compact) {
          logPrint('║${_indent(tabs)}  $e${!isLast ? ',' : ''}');
        } else {
          _printPrettyMap(
            logPrint,
            e,
            tabs: tabs + 1,
            isListItem: true,
            isLast: isLast,
          );
        }
      } else {
        logPrint('║${_indent(tabs + 2)} $e${isLast ? '' : ','}');
      }
    });
  }

  void _printMapAsTable(
    void Function(Object) logPrint,
    Map? map, {
    String? header,
  }) {
    if (map == null || map.isEmpty) return;
    logPrint('╔ $header ');
    map.forEach((dynamic key, dynamic value) =>
        _printKV(logPrint, key.toString(), value));
    _printLine(logPrint, '╚');
  }

  void _logPrintRequest(Object object) =>
      logPrint(InterceptStep.request, object);

  void _logPrintResponse(Object object) =>
      logPrint(InterceptStep.response, object);

  void _logPrintError(Object object) => logPrint(InterceptStep.error, object);
}
