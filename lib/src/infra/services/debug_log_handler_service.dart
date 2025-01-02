import 'dart:async';

import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Debug log handler that prints log messages to the console.
class DebugLogHandlerService extends LogHandlerService {
  @override
  FutureOr<void> call(LogRecord record) {
    // only called in debug mode
    // ignore: avoid_print
    print(record.formatColored());
  }

  @override
  List<String> flush() => [];

  @override
  void setBufferSize(int size) {}
}
