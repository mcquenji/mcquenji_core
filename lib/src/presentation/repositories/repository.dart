import 'package:logging/logging.dart';
import 'package:mcquenji_core/src/domain/domain.dart';

/// Mixin for all repositories that provides logging.
mixin Repository implements ILoggable {
  @override
  Level get level => Level.FINEST;

  @override
  String get namespace => "Repositories.$runtimeType";
}
