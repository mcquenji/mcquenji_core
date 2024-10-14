import 'package:logging/logging.dart';
import 'package:mcquenji_core/src/domain/domain.dart';
import 'package:modular_core/modular_core.dart';

/// Base class for all datasources.
abstract class Datasource extends ILoggable implements Disposable {
  /// The name of the datasource.
  String get name;

  @override
  Level get level => Level.FINE;

  @override
  Level get errorLevel => Level.WARNING;

  @override
  String get namespace => 'Datasources.$name';
}
