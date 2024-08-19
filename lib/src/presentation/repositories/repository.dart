import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:rxdart/subjects.dart';

/// Base class for all repositories.
///
/// As repositories are responsible for managing the state of the application, they extend [Cubit].
abstract class Repository<State> extends Cubit<State>
    implements ILoggable, Disposable {
  final List<StreamSubscription> _subscriptions = [];
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

  /// Watches another [repository] for changes.
  ///
  /// Call this method in the constructor of your repository and override the [build] method to handle changes.
  ///
  /// {@template repository_watch_example}
  /// **Example:**
  ///
  /// ```dart
  /// class MyRepository extends Repository<MyState> {
  ///   final OtherRepository _otherRepository;
  ///
  ///   MyRepository(this._otherRepository) : super(MyState.new) {
  ///     watch(_otherRepository);
  ///   }
  ///
  ///   @override
  ///   FutureOr<void> build(Type trigger) async {
  ///     final otherState = _otherRepository.state;
  ///
  ///     // Do something with otherState
  ///   }
  /// }
  /// ```
  /// {@endtemplate}
  ///
  /// For watching repositories that return an [AsyncValue], use [RepoWatchExt.watchAsync].
  /// **Note:** This repository must also return an [AsyncValue] to use [RepoWatchExt.watchAsync].
  @protected
  @nonVirtual
  void watch<T>(Repository<T> repository) {
    assert(repository != this, 'Cannot watch self');

    _subscriptions.add(
      repository.stream.listen(
        (value) => _build(
          value,
          repository,
        ),
      ),
    );
  }

  Future<void> _build<T>(T value, Repository<T> repository) async {
    Logger('$namespace.$runtimeType').log(
      Level.FINEST,
      'Received new $T from ${repository.runtimeType}: $value',
    );

    await build(repository.runtimeType);
  }

  /// Gets called when a repository watched via [watch] emits a new state.
  ///
  /// [trigger] is the type of the repository that triggered the rebuild.
  ///
  /// Override this method to handle changes from said repositories.
  ///
  /// ---
  ///
  ///{@macro repository_watch_example}
  @protected
  FutureOr<void> build(Type trigger) {}

  @override
  @mustCallSuper
  void dispose() {
    close();
    _subject.close();

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
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
    if (state == this.state) return;

    _subject.add(state);
    super.emit(state);
  }
}

/// Extension for watching asynchronous repositories in asynchronous repositories.
extension RepoWatchExt<State> on Repository<AsyncValue<State>> {
  /// Does the same as [watch] but for repositories that return an [AsyncValue].
  ///
  /// - If [setLoading] is true, this repository will emit a new state with the loading state of the watched repository.
  /// - If [setError] is true, this repository will emit a new state with the error state of the watched repository.
  ///
  /// [build] will only be called if the emmited state resolves to [AsyncValue.data] so it's safe to use [AsyncValue.requireData].
  ///
  /// In the event of [build] throwing an error, this repository will emit an error state.
  ///
  /// ---
  ///
  /// **Example:**
  ///
  /// ```dart
  /// class MyRepository extends Repository<AsyncValue<MyState>> {
  ///   final OtherRepository _otherRepository;
  ///
  ///   MyRepository(this._otherRepository) : super(MyState.new) {
  ///     watchAsync(_otherRepository);
  ///   }
  ///
  ///   @override
  ///   FutureOr<void> build() async {
  ///     final otherState = _otherRepository.state.requireData;
  ///
  ///     // Do something with otherState
  ///   }
  /// }
  /// ```
  void watchAsync<T>(
    Repository<AsyncValue<T>> repository, {
    bool setLoading = true,
    bool setError = true,
  }) {
    assert(repository != this, 'Cannot watch self');

    void onError(Object e, StackTrace? s) {
      setError ? error(e, s) : log('Error in ${repository.runtimeType}', e, s);
    }

    void onLoading() {
      setLoading ? loading() : log('${repository.runtimeType} is loading');
    }

    _subscriptions.add(
      repository.stream.listen(
        (value) => value.when(
          data: (data) => _build(
            data,
            repository,
          ).catchError(error),
          loading: onLoading,
          error: onError,
        ),
      ),
    );
  }
}
