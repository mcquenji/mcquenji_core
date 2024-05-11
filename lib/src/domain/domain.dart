import 'package:logging/logging.dart';

export 'services/services.dart';
export 'datasources/datasources.dart';

/// A class that provides logging functionality.
///
/// Each class that extends this class should have a unique [namespace].
abstract class ILoggable {
  /// The namespace to log messages under.
  /// e.g. 'Service.Auth'
  ///
  /// Note: The runtime type of the class is automatically appended to the namespace.
  String get namespace;

  /// The level to log messages at.
  Level get level;

  /// The level to log error messages at.
  ///
  /// Defaults to [Level.SEVERE].
  Level get errorLevel => Level.SEVERE;

  /// Logs a message with an optional error and stack trace.
  ///
  /// If [error] is provided, the message is logged at [errorLevel].
  void log(Object message, [Object? error, StackTrace? stackTrace]) {
    Logger("$namespace.$runtimeType").log(
      error != null ? errorLevel : level,
      message,
      error,
      stackTrace,
    );
  }
}
