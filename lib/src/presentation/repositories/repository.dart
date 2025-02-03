import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:modular_core/modular_core.dart';
import 'package:rxdart/subjects.dart';

/// {@template repository}
/// Base class for all repositories.
///
/// As repositories are responsible for managing the state of the application, they extend [Cubit].
/// {@endtemplate}
abstract class Repository<State> extends Cubit<State>
    implements ILoggable, Disposable, BuildTrigger {
  final List<StreamSubscription> _subscriptions = [];
  late final BehaviorSubject<State> _subject;

  Timer? _updateSchedule;

  final _completer = Completer<void>();

  /// Future that completes when the repository has finished initializing.
  Future<void> get ready => _completer.future;

  DateTime? _lastUpdate;

  late Duration _currentInterval;
  Duration get _maxInterval => updateInterval * 10;

  /// {@macro repository}
  Repository(State initialState) : super(initialState) {
    _subject = BehaviorSubject.seeded(initialState);

    __build(const InitialBuildTrigger()).whenComplete(_completer.complete);

    if (updateInterval != Duration.zero) {
      _currentInterval = updateInterval;
      _scheduleNextUpdate();
      log('Automatic updates enabled at ${updateInterval.inMilliseconds} ms');
    } else {
      log('Automatic updates disabled');
    }
  }

  void _scheduleNextUpdate() {
    _updateSchedule?.cancel();
    _updateSchedule = Timer(_currentInterval, _update);
  }

  Future<void> _update() async {
    // Remember the state before updating.
    final previousState = state;
    final now = DateTime.now();

    if (_lastUpdate != null &&
        now.difference(_lastUpdate!) < _currentInterval) {
      log('Update skipped: last update was too recent');
      _scheduleNextUpdate();
      return;
    }

    log('Automatic update triggered');
    await __build(const UpdateTrigger());

    // Adjust the interval based on whether state changed.
    if (const DeepCollectionEquality.unordered().equals(state, previousState)) {
      // No change? Increase the interval, up to a max.
      _currentInterval += updateInterval;
      if (_currentInterval > _maxInterval) _currentInterval = _maxInterval;
      log('No state change. Increasing update interval to '
          '${_currentInterval.inMilliseconds} ms');
    } else {
      // Change occurred? Decrease interval toward the base.
      if (_currentInterval > updateInterval) {
        _currentInterval -= updateInterval;
        if (_currentInterval < updateInterval) {
          _currentInterval = updateInterval;
        }
        log('State changed. Decreasing update interval to '
            '${_currentInterval.inMilliseconds} ms');
      }
    }

    _scheduleNextUpdate();
  }

  @override
  @mustCallSuper
  void onChange(Change<State> change) {
    super.onChange(change);

    _lastUpdate = DateTime.now();
  }

  /// The interval at which the repository should update.
  /// If [Duration.zero], the repository will not update unless triggered by another repository.
  /// When automatic updates are enabled, the [build] method will be called with [UpdateTrigger] at the specified interval.
  ///
  /// Override this getter to enable automatic updates.
  Duration get updateInterval => Duration.zero;

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
  ///
  /// For watching repositories that return an [AsyncValue], use [RepoWatchExt.watchAsync].
  /// **Note:** The repository watching must also return an [AsyncValue] to use [RepoWatchExt.watchAsync].
  /// {@endtemplate}
  @protected
  @nonVirtual
  void watch<T>(Repository<T> repository) {
    assert(repository != this, 'Cannot watch self');

    _subscriptions.add(
      repository.stream.listen(
        (value) => _build<T>(
          value,
          repository,
        ),
      ),
    );
  }

  Future<void> _build<T>(dynamic value, Repository<T> repository) async {
    Logger('$namespace.$runtimeType').log(
      Level.FINEST,
      'Received new $T from ${repository.runtimeType}: $value',
    );

    await __build(repository);
  }

  Future<void> __build(BuildTrigger trigger) async {
    try {
      await build(trigger);
    } on WaitForDataException catch (e) {
      log('Aborting build: $e');
    } catch (e) {
      rethrow;
    }
  }

  /// Recalculates the state of the repository.
  ///
  /// This method is called when:
  ///
  /// - The repository is first initialized.
  /// - A repository watched via [watch] emits a new state.
  /// - This repository is updated (if [updateInterval] is not [Duration.zero]).
  ///
  /// Override this method to handle changes from said repositories.
  ///
  /// ---
  ///
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
  ///   FutureOr<void> build(BuildTrigger trigger) async {
  ///     if(trigger is InitialBuildTrigger) {
  ///       // Do something when the repository is first initialized
  ///     }
  ///
  ///     if(trigger is UpdateTrigger) {
  ///       // Do something when the repository is updated
  ///     }
  ///
  ///     if(trigger is OtherRepository) {
  ///       // Do something when the other repository emits a new state
  ///     }
  ///   }
  /// }
  /// ```
  @protected
  FutureOr<void> build(BuildTrigger trigger) {}

  @override
  @mustCallSuper
  void dispose() {
    close();
    _subject.close();
    _updateSchedule?.cancel();

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    log('Disposed');
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
  @mustCallSuper
  void emit(State state) {
    final logger = Logger('$namespace.$runtimeType');

    if (state == this.state) {
      logger.finest('State is the same as current state, skipping emit');
      return;
    }

    logger.finest('Emitted new state: $state');

    super.emit(state);
    _subject.add(state);
  }
}

/// Extension for watching asynchronous repositories in asynchronous repositories.
extension RepoWatchExt<State> on Repository<AsyncValue<State>> {
  /// Does the same as [watch] but for repositories that return an [AsyncValue].
  ///
  /// - If [setLoading] is true, this repository will emit a new state with the loading state of the watched repository.
  /// - If [setError] is true, this repository will emit a new state with the error state of the watched repository.
  ///
  /// Use [waitForData] in [build] to wait for the data of the watched repository.
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
  ///     final otherState = waitForData(_otherRepository);
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
          data: (data) async {
            try {
              await _build<AsyncValue<T>>(
                data,
                repository,
              );
            } on WaitForDataException catch (e) {
              log('Aborting build: $e');
            } catch (e, s) {
              error(e, s);
            }
          },
          loading: onLoading,
          error: onError,
        ),
      ),
    );
  }

  /// Call this in [build] to wait for the data of a repository.
  T waitForData<T>(Repository<AsyncValue<T>> repository) {
    if (!repository.state.hasData) {
      throw WaitForDataException(T);
    }

    return repository.state.requireData;
  }
}

/// Passed as trigger in [Repository.build] when called the first time.
class InitialBuildTrigger implements BuildTrigger {
  /// Passed as trigger in [Repository.build] when called the first time.
  const InitialBuildTrigger();
}

/// Passed as trigger in [Repository.build] when called in the [Repository.updateInterval].
class UpdateTrigger implements BuildTrigger {
  /// Passed as trigger in [Repository.build] when called in the [Repository.updateInterval].
  const UpdateTrigger();
}

/// Thrown when [RepoWatchExt.waitForData] is called on a repository that does not have data yet.
class WaitForDataException implements Exception {
  /// The type of the repository that does not have data yet.
  final Type type;

  /// Thrown when [RepoWatchExt.waitForData] is called on a repository that does not have data yet.
  WaitForDataException(this.type);

  @override
  String toString() => 'Repository of type $type does not have data yet.';
}

/// Base class for all triggers that can be passed to [Repository.build].
abstract class BuildTrigger {}
