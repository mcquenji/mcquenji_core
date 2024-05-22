import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/src/domain/domain.dart';

/// Base class for all datasources.
abstract class Datasource extends ILoggable implements Disposable {
  /// The name of the datasource.
  String get name;

  @override
  Level get level => Level.FINE;

  @override
  String get namespace => "Datasources.$name";
}
