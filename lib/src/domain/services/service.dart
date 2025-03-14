import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/src/domain/domain.dart';
import 'package:modular_core/modular_core.dart';

/// Base class for all services.
abstract class Service extends Loggable implements Disposable {
  /// The name of the service.
  String get name;

  @override
  Level get level => Level.FINER;

  @override
  Level get errorLevel => Level.WARNING;

  @override
  String get namespace => 'Services.$name';

  @override
  @mustCallSuper
  void dispose() {
    log('Disposing');
  }
}
