import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/src/domain/domain.dart';
import 'package:rxdart/subjects.dart';

/// Base class for all repositories.
///
/// As repositories are responsible for managing the state of the application, they extend [Cubit].
abstract class Repository<State> extends Cubit<State>
    implements ILoggable, Disposable {
  late final BehaviorSubject<State> _subject;

  /// Base class for all repositories.
  ///
  /// As repositories are responsible for managing the state of the application, they extend [Cubit].
  Repository(State initialState) : super(initialState) {
    _subject = BehaviorSubject.seeded(initialState);
  }

  @override
  Level get level => Level.INFO;

  @override
  String get namespace => 'Repositories';

  @override
  Level get errorLevel => Level.SEVERE;

  @override
  void log(Object message, [Object? error, StackTrace? stackTrace]) {
    Logger('$namespace.$runtimeType').log(
      error != null ? errorLevel : level,
      message,
      error,
      stackTrace,
    );
  }

  @override
  @mustCallSuper
  void dispose() {
    close();
    _subject.close();
  }

  /// Shortcut for [Stream.listen].
  @nonVirtual
  StreamSubscription<State> listen(
    void Function(State)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  @nonVirtual
  Stream<State> get stream => _subject.stream;

  @override
  @nonVirtual
  void emit(State state) {
    _subject.add(state);
    super.emit(state);
  }
}
