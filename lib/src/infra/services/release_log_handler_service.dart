import 'dart:async';

import 'package:circular_buffer/circular_buffer.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A service that handles logging for release builds by storing them in a circular buffer.
class ReleaseLogHandlerService extends LogHandlerService {
  CircularBuffer<LogRecord> _buffer = CircularBuffer(100);

  @override
  FutureOr<void> call(LogRecord record) {
    _buffer.add(record);
  }

  @override
  List<String> flush() {
    final logs = _buffer.toList()..sort((a, b) => a.time.compareTo(b.time));
    _buffer.clear();
    return logs.map((record) => record.format()).toList();
  }

  @override
  void setBufferSize(int size) {
    _buffer = CircularBuffer.of(_buffer, size);
  }
}
