import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';


import '../../api/responses.dart';

///
class StreamApiError with EquatableMixin implements Exception {
  ///
  const StreamApiError(this.message);

  /// Error message
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'StreamApiError(message: $message)';
}


///
class StreamApiNetworkError extends StreamApiError {
  ///
  StreamApiNetworkError({
    int? statusCode,
    this.data,
  })  : statusCode = statusCode ?? data?.statusCode,
        super('');

  ///
  StreamApiNetworkError.raw({
    required String message,
    this.statusCode,
    this.data,
  }) : super(message);

  ///
  factory StreamApiNetworkError.fromDioError(DioException error) {
    final response = error.response;
    ErrorResponse? errorResponse;
    final data = response?.data;
    if (data != null) {
      errorResponse = ErrorResponse.fromJson(data);
    }
    return StreamApiNetworkError.raw(
      message:
          errorResponse?.message ?? response?.statusMessage ?? error.message ??"",
      statusCode: errorResponse?.statusCode ?? response?.statusCode,
      data: errorResponse,
    )..stackTrace = error.stackTrace;
  }

  /// HTTP status code
  final int? statusCode;

  /// Response body. please refer to [ErrorResponse].
  final ErrorResponse? data;

  StackTrace? _stackTrace;

  ///
  set stackTrace(StackTrace? stack) => _stackTrace = stack;

  ///
  bool get isRetriable => data == null;

  @override
  List<Object?> get props => [...super.props, statusCode];

  @override
  String toString({bool printStackTrace = false}) {
    var params = ' message: $message';
    if (statusCode != null) params += ', statusCode: $statusCode';
    if (data != null) params += ', data: $data';
    var msg = 'StreamChatNetworkError($params)';

    if (printStackTrace && _stackTrace != null) {
      msg += '\n$_stackTrace';
    }
    return msg;
  }
}
