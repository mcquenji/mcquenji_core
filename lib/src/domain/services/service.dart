import 'package:logging/logging.dart';
import 'package:mcquenji_core/src/domain/domain.dart';

/// Base class for all services.
abstract class Service extends ILoggable {
  /// The name of the service.
  String get name;

  @override
  Level get level => Level.FINER;

  @override
  String get namespace => "Service.$name";
}
