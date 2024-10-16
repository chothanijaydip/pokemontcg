import 'dart:developer';

import 'package:logging/logging.dart';
import 'api/responses.dart';
import 'api/stream_api.dart';
import 'endpoints.dart';
import 'http/stream_http_client.dart';
import 'retry_policy.dart';

/// Handler function used for logging records. Function requires a single
/// [LogRecord] as the only parameter.
typedef LogHandlerFunction = void Function(LogRecord record);

final _levelEmojiMapper = {
  Level.INFO: 'ℹ️',
  Level.WARNING: '⚠️',
  Level.SEVERE: '🚨',
};

class StreamApiClient {
  /// Create a client instance with default options.
  /// You should only create the client once and re-use it across your
  /// application.
  StreamApiClient({
    this.logLevel = Level.WARNING,
    RetryPolicy? retryPolicy,
    LogHandlerFunction? logHandlerFunction,
    Duration connectTimeout = const Duration(seconds: 25),
    Duration receiveTimeout = const Duration(seconds: 25),
  }) {
    this.logHandlerFunction = logHandlerFunction ?? _defaultLogHandler;
    logger.info('Initiating new StreamClient');

    final options = StreamHttpClientOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
    _streamApi = StreamApi(
      options: options,
      logger: detachedLogger('🕸️'),
    );
    _retryPolicy = retryPolicy ??
        RetryPolicy(
          shouldRetry: (_, attempt) => attempt < 5,
          retryTimeout: (_, attempt) => Duration(seconds: attempt),
        );
  }

  ///```
  late LogHandlerFunction logHandlerFunction;
  late final StreamApi _streamApi;

  late final RetryPolicy _retryPolicy;

  /// Additional headers for all requests
  static Map<String, Object?> additionalHeaders = {};

  /// The retry policy options getter
  RetryPolicy get retryPolicy => _retryPolicy;

  /// By default the Chat client will write all messages with level Warn or
  /// Error to stdout.
  ///
  /// During development you might want to enable more logging information,
  /// you can change the default log level when constructing the client.
  ///
  /// ```dart

  /// logLevel: Level.INFO);
  /// ```
  final Level logLevel;

  /// Client specific logger instance.
  /// Refer to the class [Logger] to learn more about the specific
  /// implementation.
  late final Logger logger = detachedLogger('📡');

  LogHandlerFunction get _defaultLogHandler => (LogRecord record) {
        log(
          '${record.time} '
          '${_levelEmojiMapper[record.level] ?? record.level.name} '
          '${record.loggerName} ${record.message} ',
        );
        if (record.error != null) log(record.error.toString());
        if (record.stackTrace != null) log(record.stackTrace.toString());
      };

  ///
  Logger detachedLogger(String name) => Logger.detached(name)
    ..level = logLevel
    ..onRecord.listen(logHandlerFunction);


  Future<GetPostListResponse> getPostListCall(
          {required Map<String, String> filter, }) =>
      _streamApi.pokemonApi.getPostList(filter: filter,);

  Future<GetPostListResponse> getPostListSearchCall(
          {required Map<String, String> filter}) =>
      _streamApi.pokemonApi.getPostListSearch(filter: filter);

}

