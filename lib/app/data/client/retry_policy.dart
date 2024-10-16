


import 'api/stream_api.dart';


/// The retry options
/// When sending/updating/deleting a message any temporary error will trigger the retry policy
/// The retry policy exposes 2 methods
/// - shouldRetry: returns a boolean if the request should be retried
/// - retryTimeout: How many milliseconds to wait till the next attempt
///
/// maxRetryAttempts is a hard limit on maximum retry attempts before giving up
class RetryPolicy {
  /// Instantiate a new RetryPolicy
  RetryPolicy({
    required this.shouldRetry,
    required this.retryTimeout,
    this.maxRetryAttempts = 6,
  });

  /// Hard limit on maximum retry attempts before giving up, defaults to 6
  /// Resets once connection recovers.
  final int maxRetryAttempts;

  /// This function evaluates if we should retry the failure
  final bool Function(
    StreamApi client,
    int attempt,
    
  ) shouldRetry;

  /// In the case that we want to retry a failed request the retryTimeout
  /// method is called to determine the timeout
  final Duration Function(
    StreamApi client,
    int attempt,
    
  ) retryTimeout;
}
