import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/src/domain/domain.dart';

/// Base class for all services.
abstract class Service extends ILoggable implements Disposable {
  /// The name of the service.
  String get name;

  @override
  Level get level => Level.FINEST;

  @override
  String get namespace => "Services.$name";
}
