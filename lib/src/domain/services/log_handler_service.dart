import 'dart:async';

import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A service that handles logging.
abstract class LogHandlerService extends Service {
  @override
  String get name => 'LogHandler';

  /// Handles a log record.
  FutureOr<void> call(LogRecord record);

  /// Returns all log messages and clears the log.
  List<String> flush();

  /// Sets the buffer size.
  void setBufferSize(int size);
}
