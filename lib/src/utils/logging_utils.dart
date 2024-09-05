import 'package:ansicolor/ansicolor.dart';
import 'package:logging/logging.dart';

/// Formatting extension for log records.
extension LogRecordX on LogRecord {
  /// Formats this record like so `time: [level] Name: message error\n\tstackTrace`.
  String format() {
    final errorstr = error != null ? error.toString() : '';
    final stackTracestr = stackTrace != null
        ? stackTrace.toString().replaceAll('\n', '\n\t')
        : '';

    final msg = toString();

    return '${time.toIso8601String()}: $msg${errorstr.isEmpty ? '' : ' '}$errorstr${stackTracestr.isEmpty ? '' : '\n\t'}$stackTracestr';
  }

  /// Returns this record formatted the same way as [format], but also colors the message based on [level].
  String formatColored() {
    final recordPen = AnsiPen();
    ansiColorDisabled = false;

    switch (level) {
      case Level.OFF:
        recordPen.black();
        break;
      case Level.FINEST:
        recordPen
          ..white()
          ..rgb(r: 0.6, g: 0.6, b: 0.6);
        break;
      case Level.FINE:
        recordPen
          ..white()
          ..rgb(r: 0.5, g: 0.5, b: 0.5);
        break;
      case Level.FINER:
        recordPen
          ..white()
          ..rgb(r: 0.7, g: 0.7, b: 0.7);
        break;
      case Level.CONFIG:
        recordPen
          ..white()
          ..rgb(r: 0.8, g: 0.8, b: 0.5);
        break;
      case Level.INFO:
        recordPen
          ..white()
          ..rgb(r: 0.2, g: 0.8, b: 0.2);
        break;
      case Level.WARNING:
        recordPen
          ..white()
          ..rgb(g: 0.8, b: 0.0);
        break;
      case Level.SEVERE:
        recordPen
          ..white()
          ..rgb(g: 0.0, b: 0.0);
        break;
      case Level.SHOUT:
        recordPen
          ..white()
          ..rgb(g: 0.0, b: 0.5);
        break;
      default:
        recordPen.white();
        break;
    }

    final stackTracePen = AnsiPen()
      ..white()
      ..rgb(r: 0.6, g: 0.6, b: 0.6);

    final errorstr = error != null
        ? error.toString().split('\n').map(recordPen).join('\n')
        : '';
    final stackTracestr = stackTrace != null
        ? stackTrace.toString().split('\n').map(stackTracePen).join('\n\t')
        : '';

    final msg = toString().split('\n').map(recordPen).join('\n');

    return recordPen.write('${time.toIso8601String()}: ') +
        msg +
        (errorstr.isEmpty ? '' : ' ') +
        errorstr +
        (stackTracestr.isEmpty ? '' : '\n\t') +
        stackTracePen.write(stackTracestr);
  }
}
