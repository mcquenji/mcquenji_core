import 'dart:async';

import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:modular_core/modular_core.dart';

/// A mixin that automatically logs the intercepted route and changes made to it.
mixin MiddlewareLogger<T> on Middleware<T> implements ILoggable {
  @override
  String get namespace => 'Middleware';

  @override
  Level get level => Level.FINER;

  @override
  Level get errorLevel => Level.SEVERE;

  @override
  FutureOr<ModularRoute?> pre(ModularRoute route) {
    log('Checking route: ${route.name}@${route.uri}');
    return route;
  }

  @override
  void log(Object message, [Object? error, StackTrace? stackTrace]) {
    Logger('$namespace.$runtimeType').log(
      error != null ? errorLevel : level,
      message,
      error,
      stackTrace,
    );
  }
}
