import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/src/domain/domain.dart';

/// Base class for all repositories.
///
/// As repositories are responsible for managing the state of the application, they extend [Cubit].
abstract class Repository<T> extends Cubit<T> implements ILoggable, Disposable {
  /// Base class for all repositories.
  ///
  /// As repositories are responsible for managing the state of the application, they extend [Cubit].
  Repository(super.initialState);

  @override
  Level get level => Level.FINEST;

  @override
  String get namespace => "Repositories";

  @override
  Level get errorLevel => Level.SEVERE;

  @override
  void log(Object message, [Object? error, StackTrace? stackTrace]) {
    Logger("$namespace.$runtimeType").log(
      error != null ? errorLevel : level,
      message,
      error,
      stackTrace,
    );
  }
}
